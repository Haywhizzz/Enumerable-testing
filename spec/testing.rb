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
end