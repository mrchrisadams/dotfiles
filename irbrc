#!/usr/bin/ruby

require 'rubygems'

# Activate auto-completion.
require 'irb/completion'

require 'irb/ext/save-history'
# enable syntax colouring later
require 'wirble'
# enable loads of cool shit
require 'utility_belt'
# so I can use awesome print (syntax: ap object) for sane object printing:
require 'ap'
# so I can use yaml (syntax: y object) for sane object printing:
require 'yaml'



IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

# IRB.conf[:PROMPT_MODE] = :SIMPLE

# IRB.conf[:AUTO_INDENT] = true
  
  
  
# pretty colors!
Wirble.init()     
colors = Wirble::Colorize.colors.merge({
  # delimiter colors
  :comma              => :white,
  :refers             => :white,

  # container colors (hash and array)
  :open_hash          => :white,
  :close_hash         => :white,
  :open_array         => :white,
  :close_array        => :white,

  # object colors
  :open_object        => :cyan,
  :object_class       => :purple,
  :object_addr_prefix => :cyan,
  :object_addr        => :light_red,
  :object_line_prefix => :cyan,
  :object_line        => :yellow,
  :close_object       => :cyan,

  # symbol colors
  :symbol             => :blue,
  :symbol_prefix      => :blue,

  # string colors
  :open_string        => :green,
  :string             => :green,
  :close_string       => :green,

  # misc colors
  :number             => :blue,
  :keyword            => :blue,
  :class              => :purple,
  :range              => :white
})                                     
Wirble::Colorize.colors = colors                                              
Wirble.colorize

# colorize prompt
IRB.conf[:PROMPT][:CUSTOM] = {
  :PROMPT_I =>    Wirble::Colorize.colorize_string(">> ", :cyan),
  :PROMPT_S =>    Wirble::Colorize.colorize_string(">> ", :green),
  :PROMPT_C => "#{Wirble::Colorize.colorize_string('..' , :cyan)} ",
  :PROMPT_N => "#{Wirble::Colorize.colorize_string('..' , :cyan)} ",
  # :RETURN   => "#{Wirble::Colorize.colorize_string('→'  , :light_red)} %s\n"
}
# IRB.conf[:PROMPT_MODE] = :CUSTOM


class Object
  # list methods which aren't in superclass
  def local_methods(obj = self)
    (obj.methods - obj.class.superclass.instance_methods).sort
  end
  
  # print documentation
  #
  #   ri 'Array#pop'
  #   Array.ri
  #   Array.ri :pop
  #   arr.ri :pop
  def ri(method = nil)
    unless method && method =~ /^[A-Z]/ # if class isn't specified
      klass = self.kind_of?(Class) ? name : self.class.name
      method = [klass, method].compact.join('#')
    end
    puts `ri '#{method}'`
  end
end

def copy(str)
  IO.popen('pbcopy', 'w') { |f| f << str.to_s }
end

def paste
  `pbpaste`
end


# load File.dirname(__FILE__) + '/.railsrc' if $0 == 'irb' && ENV['RAILS_ENV']
