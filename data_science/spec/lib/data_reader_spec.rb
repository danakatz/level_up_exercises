require "spec_helper"
require "data_reader"

describe DataReader do
  it "reports the total sample size" do
    reader = DataReader.new("data/test_data.json")
    expect(reader.total_sample_size).to be 60
  end

  it "reports the sample size for each cohort" do
    reader = DataReader.new("data/test_data.json")
    expect(reader.cohort_size("A")).to be 24
    expect(reader.cohort_size("B")).to be 36
  end

  it "reports the total number of conversions" do
    reader = DataReader.new("data/test_data.json")
    expect(reader.total_conversions).to be 14
  end

  it "reports the number of conversions for each cohort" do
    reader = DataReader.new("data/test_data.json")
    expect(reader.conversion_count("A")).to be 2
    expect(reader.conversion_count("B")).to be 12
  end

  it "keeps a list of cohorts" do
    reader = DataReader.new("data/test_data.json")
    cohort_list = ["A", "B"]
    expect(reader.cohort_list).to eq(cohort_list)
  end

  it "outputs a hash of each cohort's conversion numbers" do
    values = {}
    values["A"] = { successes: 2, failures: 22 }
    values["B"] = { successes: 12, failures: 24 }

    reader = DataReader.new("data/test_data.json")
    expect(reader.totals).to eq(values)
  end
end