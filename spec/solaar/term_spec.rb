# encoding: utf-8
require 'spec_helper'

describe Solaar::Term do
  let(:year) { Time.now().year }
  let(:solaar) { Solaar::Term.new }
  let(:record) {{ date: "#{year}-12-07", language: { ja: "大雪", en: "Major snow" }}}

  describe "#calc" do
    it "returns a collection of terms for this year" do
      expect(solaar.calc.first[:date]).to match /#{year}/
    end

    it "returns a collection of terms for the given year" do
      expect(solaar.calc(year: year).size).to eql 24
    end

    it "returns a record for the given year and month" do
      expect(solaar.calc(year: year, month: 12).first).to eql record
    end

    it "returns a record for the given month" do
      expect(solaar.calc(month: 12).size).to eql 2
      expect(solaar.calc(month: 12).first).to eql record
    end

    it "returns a record for the given month" do
      expect(solaar.calc(term: "大雪").first).to eql record
    end

    it "raises out of range error" do
      expect{ solaar.calc(year: 2100) }.to raise_error(Solaar::Exception::OutOfRange)
    end

    it "raises argument error" do
      expect{ solaar.calc(month: 'hoge') }.to raise_error(ArgumentError)
    end
  end
end
