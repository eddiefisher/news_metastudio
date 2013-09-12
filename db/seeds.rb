print 'Drop Users...'
User.unscoped.destroy_all
puts 'done.'

print 'Create Users...'
User.create(
  email: 'test@example.com',
  password: 'password'
)
puts 'done.'
