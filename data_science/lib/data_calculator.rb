class DataCalculator
  require_relative "data_reader"
  require "ABAnalyzer"
  
  attr_reader :reader

  def initialize(reader)
    @reader = reader
  end

  def conversion_rate(cohort)
    reader.conversion_count(cohort) / reader.cohort_size(cohort).to_f
  end

  def error_margin(cohort)
    conversions = reader.conversion_count(cohort)
    total = reader.cohort_size(cohort)
    interval = ABAnalyzer.confidence_interval(conversions, total, 0.95)
    interval[1] - conversion_rate(cohort)
  end

  def confidence
    tester = ABAnalyzer::ABTest.new reader.totals
    1 - tester.chisquare_p
  end

  def print_summary
    puts "Sample size: #{reader.total_sample_size}\n\n"
    reader.cohort_list.each do |c|
      rate = (conversion_rate(c) * 100).round(2)
      error = (error_margin(c) * 100).round(2)

      puts "COHORT #{c}:"
      puts "#{reader.conversion_count(c)} conversions"
      puts "Conversion rate: #{rate}% +/- #{error}\n\n"
    end
    conf = (confidence * 100).round(2)
    puts "Confidence level: #{conf}%"
  end
end
