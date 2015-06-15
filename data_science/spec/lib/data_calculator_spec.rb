require "spec_helper"
require "data_calculator"

describe DataCalculator do
  it "calculates the conversion rate for each cohort" do
    reader = DataReader.new("data/test_data.json")
    calc = DataCalculator.new(reader)
    expect(calc.conversion_rate("A")).to equal(2 / 24.to_f)
    expect(calc.conversion_rate("B")).to equal(12 / 36.to_f)
  end

  it "calculates the confidence interval for each cohort" do
    reader = DataReader.new("data/test_data.json")
    calc = DataCalculator.new(reader)
    expect(calc.error_margin("A")).to be_within(0.005).of(0.1132)
    expect(calc.error_margin("B")).to be_within(0.005).of(0.1562)
  end

  it "uses a Chi-square test to determine confidence level" do
    reader = DataReader.new("data/test_data.json")
    calc = DataCalculator.new(reader)
    expect(calc.confidence).to be_within(0.001).of(0.975)
  end
end