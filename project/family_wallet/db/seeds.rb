require('pry')
require_relative('../models/transactions.rb')
require_relative('../models/accounts.rb')
require_relative('../models/tags.rb')



account1 = Account.new({
  'holder_name' => 'Daniel',
  'holder_last_name' => 'Lara',
  'account_number' => 466567678,
  'type' => 'Personal'
  })

  account2 = Account.new({
    'holder_name' => 'Monica',
    'holder_last_name' => 'Alsina',
    'account_number' => 326567678,
    'type' => 'Personal'
    })

    account3 = Account.new({
      'holder_name' => 'Nira',
      'holder_last_name' => 'Lara Alsina',
      'account_number' => 165676456,
      'type' => 'Personal'
      })


      account4 = Account.new({
        'holder_name' => 'Lara ',
        'holder_last_name' => 'Alsina',
        'account_number' => 2656767845,
        'type' => 'Savings'
        })



  account1.save()
  account2.save()
  account3.save()
  account4.save()


    tag1 = Tag.new({
      'category' => 'Food',
      'color'    => 'Green'
      })
      tag2 = Tag.new({
        'category' => 'Alcohol',
        'color'    => 'Red'
        })
  #
        tag3 = Tag.new({
          'category' => 'Tabaco',
          'color'    => 'Red'
          })
          tag4 = Tag.new({
            'category' => 'Clothes',
            'color'    => 'Soft Green'
            })
  #
            tag5 = Tag.new({
              'category' => 'Leisure',
              'color'    => 'Green'
              })
  #
             tag6 = Tag.new({
               'category' => 'Travel',
               'color' => 'Green'
               })
  #
  #
  #
  tag1.save()
  tag2.save()
  tag3.save()
  tag4.save()
  tag5.save()
  tag6.save()


  transaction1 = Transaction.new({
    'tag_id' => 1,
    'account_id' => 1,
    'date_of_transaction' => '12-01-2017',
    'type' => 'spense',
    'quantity' => 345.34,
    'issuer' => 'Tesco'
  })
  #
  #
  #
    transaction2 = Transaction.new({
      'tag_id' => 2,
      'account_id' => 3,
      'date_of_transaction' => '1-1-2017',
      'type' => 'Income',
      'quantity' => 232.45,
      'issuer' => 'Sykes Global'
    })



      transaction3 = Transaction.new({
        'tag_id' => 3,
        'account_id' => 2,
        'date_of_transaction' => '03-02-2017',
        'type' => 'spense',
        'quantity' => 32.84,
        'issuer' => 'Sainsburys'
      })



        transaction4 = Transaction.new({
          'tag_id' => 1,
          'account_id' => 1,
          'date_of_transaction' => '12-01-2017',
          'type' => 'spense',
          'quantity' => 345.45,
          'issuer'   => 'Easyjet'
        })


        transaction1.save()
          transaction2.save()
            transaction3.save()
              transaction4.save()

# @tags_id, @accounts_id, @date, @income, @espenses

binding.pry
nil