require "por_flatten/version"

module PorFlatten
  class DataTypeError < StandardError; end

  # This method does the flattening.  The approach is keep the number of nested
  # loops to a minimum by descending all the way into nested arrays immediately
  # and moving non-array elements to the new results array as they occurr.
  # We maintain a data "stack" containing the parent array and the index of the
  # next yet-to-be-processed element.  The loop whitles away at the stack until
  # no more elements in the root level array remain.
  #
  # == Parameters:
  # +array+::
  #   [Array] Required.
  #   The array to flatten.
  # +integers_only+::
  #   [Boolean] Required. Default = True
  #   Whether to allow only integers values, aside from nested arrays.
  #
  # == Returns:
  # An single-level array.
  #
  # == Example:
  # a = [1, 2, [3, 4]]
  # PorFlatten.flatten(array: a)
  # => [1, 2, 3, 4]
  def self.flatten(array:, integers_only: true)
    # Index for second loop
    i = 0
    # Stack of elements to process later (to avoid many nested loops)
    stack = []
    # To avoid a while(true) loop, we use stack.length in loop 1.  But we need
    # a way to detect whether the current iteration is the first one or not.
    not_run = true
    # The result we are building.
    result = []

    # Iterate through the stack.  Since the stack starts empty, we still iterate
    # if we haven't started yet.
    while not_run || stack.length > 0
      # On first run, stack is empty.
      unless not_run
        # In the next loop, when an array element is encountered, we start
        # processing it immediately.  We save the then current array and position
        # in the stack.  Once an entire non-array-containing element is processed,
        # we return from the stack to resume the higher-level element at the next
        # position in the array.
        array_data = stack.pop
        i = array_data[:next_index]
        array = array_data[:array]
      end
      not_run = false

      # This loop processes an array, moving the element into the result array or
      # if the element is another Array, we move the current array and position
      # into the stack, and start processing the new nested array.
      while i < array.length
        element = array[i]
        i += 1

        if element.instance_of? Array
          # If in fact the current element is an array, we want to descend into it
          # so we can move non-array values into the result, but we want to come
          # back to the remaining elements in the currently processing array, so
          # we add that array and the current position to the stack.
          stack << {array: array, next_index: i}
          array = element
          i = 0
        else
          # Handles the option to disallow non-integer result values.
          if integers_only && !element.instance_of?(Integer)
            raise DataTypeError, 'The array element must be either an Integer or an Array'
          else
            result << element
          end
        end
      end
    end

    result
  end
end

class Array
  # We add the +por_flatten+ method to Array instances for ease of use
  def por_flatten(integers_only: true)
    PorFlatten.flatten(array: self, integers_only: integers_only)
  end
end
