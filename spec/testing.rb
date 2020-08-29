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
