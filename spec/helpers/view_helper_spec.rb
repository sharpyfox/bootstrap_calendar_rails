# encoding: utf-8

require "spec_helper"
require "bootstrap_calendar_rails"

include BootstrapCalendarRails::ViewHelpers

describe BootstrapCalendarRails do
  it 'should build something' do
    square = Proc.new do |date|
      date.to_s
    end

    obj = BootstrapCalendar.new view, Date.today, {}, square
    obj.build.should_not be_empty
  end

  it 'should return correct days by default' do
    square = Proc.new do |date|
      date.to_s
    end

    obj = BootstrapCalendar.new view, Date.today, {}, square

    obj.send(:day_names).should == %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday]
    obj.send(:mobile_day_names).should == %w[Sun Mon Tues Wed Thur Fri Sat]
  end

  it 'should return days with correct start_date' do
    square = Proc.new do |date|
      date.to_s
    end

    obj = BootstrapCalendar.new view, Date.today, { start_day: :wednesday }, square

    obj.send(:day_names).should == %w[Wednesday Thursday Friday Saturday Sunday Monday Tuesday]
    obj.send(:mobile_day_names).should == %w[Wed Thur Fri Sat Sun Mon Tues]
  end

  it 'should return days with wrong start_date' do
    square = Proc.new do |date|
      date.to_s
    end

    obj = BootstrapCalendar.new view, Date.today, { start_day: :yesterday }, square

    obj.send(:day_names).should == %w[Sunday Monday Tuesday Wednesday Thursday Friday Saturday]
    obj.send(:mobile_day_names).should == %w[Sun Mon Tues Wed Thur Fri Sat]
  end

  it 'should call callback' do
    called = false
    square = Proc.new do |date|
      called = true
    end

    called.should be_false
    obj = BootstrapCalendar.new view, Date.today, {}, square
    obj.build
    called.should be_true
  end

  it 'should call extra class callback' do
    called = false
    square = Proc.new do |date|
      date.to_s
    end

    options = { extra_day_classes: lambda { |classes, day| called = true } }
    called.should be_false
    obj = BootstrapCalendar.new view, Date.today, options, square
    obj.build
    called.should be_true
  end
end