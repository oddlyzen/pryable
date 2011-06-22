module Pryable
  require 'benchmark'
  # begin  
  #   require 'pry'  
  #   module Rails  
  #     class Console  
  #       class IRB  
  #         def self.start  
  #           Pry.start  
  #         end  
  #       end   
  #     end  
  #   end  
  # rescue LoadError  
  # end
  
  module Version
    MAJOR = 0
    MINOR = 1
    PATCH = 4
    BUILD = 'pre'
    
    STRING = [MAJOR, MINOR, PATCH, (BUILD unless BUILD.empty?)].compact.join('.')
  end
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  def pry_open
    log_prying_session {
      binding.pry
    }
  end
  
  def log_prying_session(&block)
    Rails.logger.info "====== Beginning Pry Session ====== Binding: #{self.inspect} ======"
    start = Time.now
    yield
    finish = Time.now
    elapsed = finish.to_f - start.to_f
    mins, secs = elapsed.divmod 60.0
    min = mins.zero? ? "" : "#{mins.ceil}m "
    sec = "#{secs.ceil}s"
    time = min + sec
    Rails.logger.info "====== Ending Pry Session ====== Session Time: #{time} ======"
  end

  
  module ClassMethods
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
  end
end