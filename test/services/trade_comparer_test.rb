# frozen_string_literal: true

require "test_helper"

class TradeComparerTest < ActiveSupport::TestCase
  setup do
    # User A owns positions 1-10, duplicates at 1,2,3
    @user_a = create_user(name: "A", email: "a@test.com")
    CollectionImporter.new(@user_a, {
      owned: Set.new(1..10),
      duplicates: { 1 => 1, 2 => 1, 3 => 1 }
    }).call

    # User B owns positions 5-15, duplicates at 11,12,13
    @user_b = create_user(name: "B", email: "b@test.com")
    CollectionImporter.new(@user_b, {
      owned: Set.new(5..15),
      duplicates: { 11 => 1, 12 => 1, 13 => 1 }
    }).call
  end

  test "a_gives_b are A's duplicates that B is missing" do
    result = TradeComparer.new(@user_a, @user_b).call

    # A has dupes at 1,2,3 — B is missing 1,2,3,4 — overlap is 1,2,3
    positions = result.a_gives_b.map(&:position)
    assert_equal [ 1, 2, 3 ], positions
  end

  test "b_gives_a are B's duplicates that A is missing" do
    result = TradeComparer.new(@user_a, @user_b).call

    # B has dupes at 11,12,13 — A is missing 11-994 — overlap is 11,12,13
    positions = result.b_gives_a.map(&:position)
    assert_equal [ 11, 12, 13 ], positions
  end

  test "balanced trade matches within categories" do
    result = TradeComparer.new(@user_a, @user_b).call

    # Positions 1-3 are FWC (shiny), positions 11-13 are CC (11=coke) + MEX 1 (12? no)
    # Let's just verify balanced counts match
    balanced = result.balanced
    [ :shiny, :coke, :normal ].each do |cat|
      assert_equal balanced.send(cat).a_gives.size, balanced.send(cat).b_gives.size,
        "Balanced #{cat} should have equal sides"
    end
  end

  test "leftovers are what couldn't be balanced" do
    result = TradeComparer.new(@user_a, @user_b).call
    leftovers = result.leftovers

    total_a = result.a_gives_b.size
    balanced_a = [ :shiny, :coke, :normal ].sum { |c| result.balanced.send(c).a_gives.size }
    assert_equal total_a - balanced_a, leftovers.a_has.size
  end

  test "returns empty results when no trade possible" do
    # User with no duplicates
    user_c = create_user(name: "C", email: "c@test.com")
    CollectionImporter.new(user_c, { owned: Set.new(1..994), duplicates: {} }).call

    result = TradeComparer.new(@user_a, user_c).call

    assert_empty result.b_gives_a
  end
end
