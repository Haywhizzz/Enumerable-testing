require_relative '../main'

describe Enumerable do
  let(:array) { [1, 2, 3] }
  let(:array_a) { [false, 5, 3] }
  let(:array_b) { [2, nil, 3] }
  let(:array_c) { [3, 3, 3] }
  let(:array_d) { [true, 5, 3] }
  let(:array_e) { [false, nil] }
  let(:words_a) { %w[dog door rod blade] }
  let(:words_b) { %w[dog door dod dlade] }
  let(:words_c) { %w[cog coor bod elade] }
  let(:block) { proc { |x| x * 2 } }
  let(:inject_block) { proc { |prod, num| prod * num } }
  let(:block_with_index) { proc { |num, i| puts "Num: #{num}, index: #{i}" } }
  let(:range) { (1..5) }
  let(:range_a) { ('a'..'b') }
  let(:range_b) { (1..1) }
  let(:my_hash) { { first_name: 'oyeleke', second_name: 'gurbuz' } }
  let(:hash_block) { proc { |key, value| puts "#{key} is #{value}" } }
  let(:expression) { '/d/' }
  let(:new_array) { [] }

  describe '#my_each' do
    it 'return Enumerator if no block is given' do
      expect(array.my_each).to be_a(Enumerator)
    end

    it 'Iterates through the array and executes block' do
      counter = 0
      pr = proc { counter += 1 }
      array.my_each { pr.call }
      expect(counter).to eql(array.size)
    end

    it 'Iterates through the range and executes block' do
      counter = 0
      pr = proc { counter += 1 }
      range.my_each { pr.call }
      expect(counter).to eq(range.size)
    end

    it 'Iterates through the hash and executes block' do
      expect(my_hash.my_each(&block)).to eq(my_hash.each(&block))
    end

    it 'Iterates through the hash and executes block' do
      expect(my_hash.my_each(&hash_block)).to eq(my_hash.each(&hash_block))
    end
  end
  describe '#my_each_with_index' do
    it 'returns Enumerator if no block is given' do
      expect(array.my_each_with_index).to be_a(Enumerator)
    end

    it 'Iterates through the array and executes block' do
      counter = 0
      pr = proc { counter += 1 }
      array.my_each_with_index { pr.call }
      expect(counter).to eql(array.size)
    end

    it 'Iterates through the array and executes block' do
      expect(array.my_each_with_index(&block)).to eq(array.each_with_index(&block))
    end

    it 'Iterates through the array and executes block' do
      expect(array.my_each_with_index(&block_with_index)).to eq(array.each_with_index(&block_with_index))
    end
  end

  describe '#my_select' do
    it 'it iterates the array and return Enumerator if no block is given' do
      expect(array.my_select).to be_a(Enumerator)
    end

    it 'iterates through the array and returns the satisfying items in the array' do
      expect(array.my_select(&block)).to eql(array.select(&block))
    end

    it 'Iterates through the range and executes block' do
      expect(range.my_select(&block)).to eq(range.select(&block))
    end
  end

  describe '#my_all?' do
    it 'returns true if none of the array items are false when no block or argument given' do
      expect(array.my_all?).to eq(true)
    end

    it 'returns false if any of the array items are false when no block or argument given' do
      expect(array_a.my_all?).to eq(false)
    end

    it 'returns true if none of the array items are nil when no block or argument given' do
      expect(array.my_all?).to eq(true)
    end

    it 'returns false if any of the array items are nil when no block or argument given' do
      expect(array_b.my_all?).to eq(false)
    end

    it 'returns true if all of the array items are member of class given' do
      expect(array.my_all?(Numeric)).to eq(true)
    end

    it 'returns false if any of the array items are not member of class given' do
      expect(array_a.my_all?(Numeric)).to eq(false)
    end

    it 'returns true if all of the array items matches the Regex given' do
      expect(words_b.my_all?(/d/)).to eq(true)
    end

    it "returns false if any of the array items doesn\'t match the Regex given" do
      expect(words_a.my_all?(expression)).to eq(false)
    end

    it 'returns true if all of the array items matches the value given' do
      expect(array_c.my_all?(3)).to eq(true)
    end

    it "returns false if any of the array items doesn\'t match the value given" do
      expect(array.my_all?(3)).to eq(false)
    end

    it 'returns true if none of the range items are false when no block or argument given' do
      expect(range.my_all?).to eq(true)
    end

    it 'returns true if all of the range items are member of class given' do
      expect(range.my_all?(Numeric)).to eq(true)
    end

    it 'returns false if any of the range items are not member of class given' do
      expect(range_a.my_all?(Numeric)).to eq(false)
    end

    it 'returns true if all of the range items matches the given value' do
      expect(range_b.my_all?(1)).to eq(true)
    end

    it 'returns false if any of the range items dont match the given value' do
      expect(range.my_all?(6)).to eq(false)
    end
  end

  describe '#my_any?' do
    it 'returns true if any of the array items are true when no block or argument given' do
      expect(array_d.my_any?).to eq(true)
    end

    it 'returns false if none of the array items are true when no block or argument given' do
      expect(array_e.my_any?).to eq(false)
    end

    it 'returns true if any of the array items are member of such class' do
      expect(array.my_any?(Numeric)).to eq(true)
    end

    it 'returns false if none of the array items are member of such class' do
      expect(array_e.my_any?(Numeric)).to eq(false)
    end

    it 'returns true if any of the array items matches regex given' do
      expect(words_a.my_any?(/d/)).to eq(true)
    end

    it 'returns false if none of the array items matches regex given' do
      expect(words_c.my_any?(/i/)).to eq(false)
    end

    it 'returns true if any of the array items matches the given value' do
      expect(array.my_any?(3)).to eq(true)
    end

    it 'returns false if none of the array items matches the given value' do
      expect(array_e.my_any?(3)).to eq(false)
    end

    it 'returns true if any of the range items are member of given class' do
      expect(range.my_any?(Numeric)).to eq(true)
    end

    it 'returns false if none of the range items are member of given class' do
      expect(range_a.my_any?(Numeric)).to eq(false)
    end

    it 'returns true if any of the range items matches the given value' do
      expect(range.my_any?(3)).to eq(true)
    end

    it 'returns false if none of the range items matches the given value' do
      expect(range_a.my_any?(3)).to eq(false)
    end
  end

  describe '#my_none?' do
    it 'returns true if none of the array items are true when no block or argument given' do
      expect(array_e.my_none?).to eq(true)
    end

    it 'returns false if any of the array items are true when no block or argument given' do
      expect(array_a.my_none?).to eq(false)
    end

    it 'returns true if none of the array items are member of such class' do
      expect(array_e.my_none?(Numeric)).to eq(true)
    end

    it 'returns false if any of the array items are member of such class' do
      expect(array.my_none?(Numeric)).to eq(false)
    end

    it 'returns true if none of the array items matches regex given' do
      expect(words_c.my_none?(/i/)).to eq(true)
    end

    it 'returns false if any of the array items matches regex given' do
      expect(words_b.my_none?(/r/)).to eq(false)
    end

    it 'returns true if none of the array items matches the given value' do
      expect(array_c.my_none?(5)).to eq(true)
    end

    it 'returns false if any of the array items matches the given value' do
      expect(array_a.my_none?(5)).to eq(false)
    end

    it 'returns true if none of the range items are member of given class' do
      expect(range_a.my_none?(Numeric)).to eq(true)
    end

    it 'returns false if any of the range items are member of given class' do
      expect(range_b.my_none?(Numeric)).to eq(false)
    end

    it 'returns true if none of the range items matches the given value' do
      expect(range.my_none?(6)).to eq(true)
    end

    it 'returns false if any of the range items matches the given value' do
      expect(range.my_none?(3)).to eq(false)
    end
  end

  describe '#my_count' do
    it 'returns the number of items in the array through enumeration' do
      expect(array.my_count).to eq(array.count)
    end

    it 'returns the number of items in the range through enumeration' do
      expect(range.my_count).to eq(range.count)
    end

    it 'returns the number of items in the range through enumeration' do
      expect(array.my_count(&block)).to eq(array.count(&block))
    end

    it 'returns the number of items in the array through enumeration' do
      expect(array.my_count(3)).to eq(array.count(3))
    end

    it 'returns the number of items in the range through enumeration' do
      expect(range.my_count(3)).to eq(range.count(3))
    end
  end

  describe '#my_map' do
    it 'returns an Enumerator if no block is given' do
      expect(array.my_map).to be_a(Enumerator)
    end

    it 'returns an Enumerator if no block is given' do
      expect(range.my_map).to be_a(Enumerator)
    end

    it 'returns a new array after block executed for each item' do
      new_array = array.my_map(&block)
      expect(new_array).not_to eq(array)
    end

    it 'keeps the original array same' do
      array.my_map(&block)
      expect(array).to eq(array)
    end

    it 'returns a new array after block executed for each item' do
      expect(range.my_map(&block)).to eq(range.map(&block))
    end

    it 'Iterates through the hash and executes block' do
      expect(my_hash.my_map(&block)).to eq(my_hash.map(&block))
    end

    it 'Iterates through the hash and executes block' do
      expect(my_hash.my_map(&hash_block)).to eq(my_hash.map(&hash_block))
    end
  end

  describe '#my_inject' do
    it 'combine all elements of enum by applying a binary operation, specified by a block' do
      expect(array.my_inject(&inject_block)).to eq(array.inject(&inject_block))
    end

    it 'combines all elements of enum by applying a binary operation, specified by a block and the value' do
      expect(array.my_inject(3, &inject_block)).to eq(array.inject(3, &inject_block))
    end

    it 'combines all elements of enum by applying a binary operation, specified by a block' do
      expect(range.my_inject(&inject_block)).to eq(range.inject(&inject_block))
    end

    it 'combines all elements of enum by applying a binary operation, specified by a block and the value' do
      expect(range.my_inject(3, &inject_block)).to eq(range.inject(3, &inject_block))
    end

    it 'combines each element of the collection by applying the symbol' do
      expect(array.my_inject(:+)).to eq(array.inject(:+))
    end

    it 'combines each element of the collection by applying the symbol' do
      expect(array.my_inject(3, :*)).to eq(array.inject(3, :*))
    end

    it 'combines each element by applying the symbol' do
      expect(range.my_inject(:+)).to eq(range.inject(:+))
    end

    it 'combines each element of the collection by applying the symbol and inject the value given' do
      expect(range.my_inject(3, :*)).to eq(range.inject(3, :*))
    end
  end
end
