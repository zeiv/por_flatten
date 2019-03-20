require "test_helper"

class PorFlattenTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::PorFlatten::VERSION
  end

  def test_it_does_not_affect_already_flat_arrays
    a = [1, 2, 3, 4]
    assert a == a.por_flatten
  end

  def test_it_works_on_empty_arrays
    a = []
    assert a.por_flatten == []
  end

  def test_it_actually_flattens
    a = [1, 2, [3, 4]]
    assert a.por_flatten == [1, 2, 3, 4]
  end

  def test_it_flattens_the_theorem_example
    a = [[1, 2, [3]], 4]
    assert a.por_flatten == [1, 2, 3, 4]
  end

  def test_it_flattens_complex_arrays
    a = [
      [
        [1, 2]
      ],
      [],
      [
        3, [[4]]
      ]
    ]
    assert a.por_flatten == [1, 2, 3, 4]
  end

  def test_it_allows_only_integers_by_default
    a = [1, 2, 'three']
    assert_raises PorFlatten::DataTypeError do
      a.por_flatten
    end
  end

  def test_it_can_flatten_non_integers_on_request
    a = [['one', 'two',], ['three', 'four']]
    assert a.por_flatten(integers_only: false) == ['one', 'two', 'three', 'four']
  end
end
