class DataReader
  require_relative "data_loader"
  require "set"
  
  attr_reader :data_hash, :cohort_list, :counts_hash

  def initialize(file_name)
    @data_hash = DataLoader.load(file_name)
    cohort_set = Set.new
    @data_hash.each { |visit| cohort_set.add visit["cohort"] }
    @cohort_list = cohort_set.to_a.sort
  end

  def total_sample_size
    data_hash.count
  end

  def cohort_size(cohort)
    data_hash.count { |x| x["cohort"] == cohort }
  end

  def total_conversions
    data_hash.count { |x| x["result"] == 1 }
  end

  def conversion_count(cohort)
    select_conversions(cohort).count
  end

  def select_conversions(cohort)
    data_hash.select do |x|
      x["result"] == 1 && x["cohort"] == cohort
    end
  end

  def totals
    if counts_hash.nil?
      @counts_hash = {}
      cohort_list.each do |c|
        @counts_hash[c] = {}
        @counts_hash[c][:successes] = conversion_count(c)
        @counts_hash[c][:failures] = cohort_size(c) - conversion_count(c)
      end
    end
    counts_hash
  end
end
