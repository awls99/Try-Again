Gem::Specification.new do |s|
  s.name        = 'try_again'
  s.version     = '2.0.1'
  s.date        = Time.now.strftime('%Y-%m-%d')
  s.summary     = 'A helping method to to retry a block a few times with a sleep in between'
  s.description = <<EOF
  This method is usefull for when you want to attempt to get a resource on a network and it may fail \n
  Or maybe you know that there's a possibility that the databases haven't sync yet and you want to try a few times till they do
EOF
  s.authors     = ["Arthur Silva"]
  s.email       = 'awls99@gmail.com'
  s.files       = %w[lib/try_again.rb README]
  s.homepage    = 'https://github.com/awls99/Try-Again'
  s.license     = 'MIT'
end

