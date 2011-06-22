module Pryable
  
  begin  
    require 'pry'  
    module Rails  
      class Console  
        class IRB  
          def self.start  
            Pry.start  
          end  
        end   
      end  
    end  
  rescue LoadError  
  end
  
  module Version
    MAJOR = 0
    MINOR = 1
    PATCH = 3
    #BUILD = ''
    
    STRING = [MAJOR, MINOR, PATCH].compact.join('.')
  end
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  def pry_open
    start_time = DateTime.now
    Rails.logger.info "====== Beginning Pry Session ====== Binding: #{self.inspect} ======"
    binding.pry
    end_time = DateTime.now
    elapsed = end_time - start_time
    Rails.logger.info "====== Ending Pry Session ====== Time Elapsed: #{elapsed} ======"
  end

  
  module ClassMethods
    require 'pry'
  end
end