# frozen_string_literal: true

require "minitest/autorun"
require "tmpdir"
require "fileutils"

load File.expand_path("../../bin/okf", __dir__)

class OkfScriptTest < Minitest::Test
  def setup
    @dir = Dir.mktmpdir("okf_test")
    FileUtils.mkdir_p(File.join(@dir, ".git"))
    @root = Pathname.new(@dir)
  end

  def teardown
    FileUtils.rm_rf(@dir)
  end

  # --- Listing ---

  def test_lists_docs_grouped_by_type
    write_doc("README.md", type: "Project Overview", description: "An app")
    write_doc("AGENTS.md", type: "Agent Instructions", description: "Rules for agents")
    write_doc("docs/adr/0001.md", type: "Architecture Decision Record", description: "Why Postgres")

    output = format_listing

    assert_includes output, "## Project Overview"
    assert_includes output, "## Agent Instructions"
    assert_includes output, "## Architecture Decision Record"
    assert_includes output, "README.md — An app"
    assert_includes output, "AGENTS.md — Rules for agents"
    assert_includes output, "docs/adr/0001.md — Why Postgres"
  end

  def test_falls_back_to_title_when_no_description
    write_doc("notes.md", type: "Glossary", title: "Domain terms")

    output = format_listing

    assert_includes output, "notes.md — Domain terms"
  end

  def test_shows_path_only_when_no_description_or_title
    write_doc("bare.md", type: "Glossary")

    output = format_listing

    assert_includes output, "bare.md\n"
    refute_includes output, "bare.md —"
  end

  def test_skips_reserved_filenames
    write_doc("index.md", type: "Index", title: "Should be skipped")
    write_doc("docs/index.md", type: "Index", title: "Also skipped")
    write_doc("log.md", type: "Log", title: "Skipped too")
    write_doc("real.md", type: "Glossary", title: "Included")

    docs = Okf.scan(@root)

    assert_equal 1, docs.size
    assert_equal "real.md", docs.first["_path"]
  end

  def test_skips_excluded_directories
    write_doc(".agents/skill.md", type: "Skill", title: "Hidden")
    write_doc("vendor/gem/README.md", type: "Docs", title: "Hidden")
    write_doc("node_modules/pkg/README.md", type: "Docs", title: "Hidden")
    write_doc("visible.md", type: "Glossary", title: "Visible")

    docs = Okf.scan(@root)

    assert_equal 1, docs.size
    assert_equal "visible.md", docs.first["_path"]
  end

  def test_skips_files_without_frontmatter
    File.write(File.join(@dir, "plain.md"), "# Just markdown\nNo frontmatter.")
    write_doc("real.md", type: "Glossary", title: "Real doc")

    docs = Okf.scan(@root)

    paths = docs.map { |d| d["_path"] }
    refute_includes paths, "plain.md"
    assert_includes paths, "real.md"
  end

  def test_skips_files_with_frontmatter_but_no_type
    write_doc("orphan.md", title: "No type field")
    write_doc("typed.md", type: "Glossary", title: "Has type")

    docs = Okf.scan(@root)

    paths = docs.map { |d| d["_path"] }
    refute_includes paths, "orphan.md"
    assert_includes paths, "typed.md"
  end

  # --- Type filter ---

  def test_type_filter_substring_match
    write_doc("a.md", type: "Folder Contract", title: "App folder")
    write_doc("b.md", type: "Architecture Decision Record", title: "ADR one")

    docs = Okf.scan(@root).select { |d| Okf.matches_type?(d, "folder") }

    assert_equal [ "a.md" ], docs.map { |d| d["_path"] }
  end

  def test_type_filter_initials_match
    write_doc("a.md", type: "Architecture Decision Record", title: "First ADR")
    write_doc("b.md", type: "Folder Contract", title: "A contract")

    docs = Okf.scan(@root).select { |d| Okf.matches_type?(d, "adr") }

    assert_equal [ "a.md" ], docs.map { |d| d["_path"] }
  end

  def test_type_filter_case_insensitive
    write_doc("a.md", type: "Glossary", title: "Terms")

    docs = Okf.scan(@root).select { |d| Okf.matches_type?(d, "GLOSSARY") }

    assert_equal [ "a.md" ], docs.map { |d| d["_path"] }
  end

  # --- Grep filter ---

  def test_grep_searches_title
    write_doc("a.md", type: "Glossary", title: "Trade terms", description: "Unrelated")
    write_doc("b.md", type: "Glossary", title: "Unrelated", description: "Unrelated")

    docs = Okf.scan(@root).select { |d| Okf.matches_grep?(d, "trade") }

    assert_equal [ "a.md" ], docs.map { |d| d["_path"] }
  end

  def test_grep_searches_description
    write_doc("a.md", type: "Glossary", title: "Unrelated", description: "About sticker trading")
    write_doc("b.md", type: "Glossary", title: "Unrelated", description: "About nothing")

    docs = Okf.scan(@root).select { |d| Okf.matches_grep?(d, "trading") }

    assert_equal [ "a.md" ], docs.map { |d| d["_path"] }
  end

  def test_grep_searches_tags
    write_doc("a.md", type: "Glossary", title: "Terms", tags: %w[domain trade])
    write_doc("b.md", type: "Glossary", title: "Other", tags: %w[config])

    docs = Okf.scan(@root).select { |d| Okf.matches_grep?(d, "trade") }

    assert_equal [ "a.md" ], docs.map { |d| d["_path"] }
  end

  def test_grep_case_insensitive
    write_doc("a.md", type: "Glossary", title: "PHLEX components")

    docs = Okf.scan(@root).select { |d| Okf.matches_grep?(d, "phlex") }

    assert_equal [ "a.md" ], docs.map { |d| d["_path"] }
  end

  # --- Combined filters ---

  def test_type_and_grep_combined
    write_doc("a.md", type: "Architecture Decision Record", title: "Use Postgres")
    write_doc("b.md", type: "Architecture Decision Record", title: "Use Redis")
    write_doc("c.md", type: "Glossary", title: "Postgres terms")

    docs = Okf.scan(@root)
      .select { |d| Okf.matches_type?(d, "adr") }
      .select { |d| Okf.matches_grep?(d, "postgres") }

    assert_equal [ "a.md" ], docs.map { |d| d["_path"] }
  end

  # --- Check mode ---

  def test_check_passes_when_all_fields_present
    write_doc("a.md", type: "Glossary", title: "Terms", description: "All terms", tags: %w[domain], timestamp: "2026-01-01T00:00:00Z")

    issues = Okf.check(@root)
    result = Okf.format_check(issues)

    assert_equal 0, result[:status]
    assert_includes result[:output], "All OKF documents pass validation."
  end

  def test_check_reports_missing_fields
    write_doc("incomplete.md", type: "Glossary", title: "Terms")

    issues = Okf.check(@root)
    result = Okf.format_check(issues)

    assert_equal 1, result[:status]
    assert_includes result[:output], "incomplete.md: missing description, tags, timestamp"
  end

  def test_check_reports_invalid_yaml
    path = File.join(@dir, "broken.md")
    File.write(path, "---\ntype: [unclosed\n---\nBody.\n")

    issues = Okf.check(@root)
    result = Okf.format_check(issues)

    assert_equal 1, result[:status]
    assert_includes result[:output], "broken.md: invalid YAML:"
  end

  def test_check_ignores_files_without_frontmatter
    File.write(File.join(@dir, "plain.md"), "# No frontmatter\nJust text.")
    write_doc("good.md", type: "Glossary", title: "T", description: "D", tags: %w[t], timestamp: "2026-01-01T00:00:00Z")

    issues = Okf.check(@root)
    result = Okf.format_check(issues)

    assert_equal 0, result[:status]
    refute_includes result[:output], "plain.md"
  end

  # --- Help ---

  def test_help_includes_all_options
    assert_includes Okf::HELP, "Usage: bin/okf"
    assert_includes Okf::HELP, "--type=TYPE"
    assert_includes Okf::HELP, "--grep=QUERY"
    assert_includes Okf::HELP, "--check"
  end

  # --- Empty repo ---

  def test_empty_repo_returns_empty_scan
    docs = Okf.scan(@root)

    assert_empty docs
  end

  # --- Repo root detection ---

  def test_repo_root_finds_git_directory
    subdir = File.join(@dir, "app", "models")
    FileUtils.mkdir_p(subdir)

    root = Okf.repo_root(from: subdir)

    assert_equal @root.to_s, root.to_s
  end

  def test_repo_root_returns_nil_outside_repo
    Dir.mktmpdir("no_git") do |dir|
      root = Okf.repo_root(from: dir)
      assert_nil root
    end
  end

  private

  def write_doc(rel_path, **fields)
    path = File.join(@dir, rel_path)
    FileUtils.mkdir_p(File.dirname(path))

    frontmatter = {}
    frontmatter["type"] = fields[:type] if fields[:type]
    frontmatter["title"] = fields[:title] if fields[:title]
    frontmatter["description"] = fields[:description] if fields[:description]
    frontmatter["tags"] = fields[:tags] if fields[:tags]
    frontmatter["timestamp"] = fields[:timestamp] if fields[:timestamp]

    content = "---\n"
    frontmatter.each do |k, v|
      if v.is_a?(Array)
        content += "#{k}: [#{v.join(", ")}]\n"
      else
        content += "#{k}: '#{v}'\n"
      end
    end
    content += "---\n\nBody content.\n"

    File.write(path, content)
  end

  def format_listing
    docs = Okf.scan(@root)
    Okf.format_grouped(docs)
  end
end
