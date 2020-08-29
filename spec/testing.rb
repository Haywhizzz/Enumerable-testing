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

  
end