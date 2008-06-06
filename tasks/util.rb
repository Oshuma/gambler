# Utility methods.

# Ask for confirmation.  Returns true/false
def confirm(message, options = {})
  confirm_message = options[:confirm_message] || 'Are you sure?'
  banner = options[:banner] || false
  if banner
    header(message) # print with header
    print "#{confirm_message} (yes/no) "
    choice = STDIN.gets.chomp
  else
    puts message
    print "#{confirm_message} (yes/no) "
    choice = STDIN.gets.chomp
  end

  case choice
  when 'yes'
    return true
  else
    puts 'Aborted'
  end
end

# Displays +message+ inside a formatted header.
def header(message = nil)
  raise ArgumentError, 'No message passed to header.' unless message
  puts "\n"
  puts '+---'
  puts "| #{message}"
  puts '+---'
end