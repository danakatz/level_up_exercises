require "spec_helper"
require "data_loader"

describe DataLoader do
  it "reads data from a json file" do
    file_name = "data/data_export_2014_06_20_15_59_02.json"
    expect(DataLoader.load(file_name)).to be_an(Array)
  end
end