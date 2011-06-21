module Pryable
  
  module Version
    MAJOR = 0
    MINOR = 1
    PATCH = 1
    #BUILD = ''
    
    STRING = [MAJOR, MINOR, PATCH].compact.join('.')
  end
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  def pry_open
    binding do |b|
      start_time = DateTime.now
      Rails.logger.info "====== Beginning Pry Session ====== Binding: #{self.inspect} ======"
      b.pry
      end_time = DateTime.now
      elapsed = end_time - start_time
      Rails.logger.info "====== Ending Pry Session ====== Time Elapsed: #{elapsed} ======"
    end
  end

  
  module ClassMethods
    require 'pry'
  end
end