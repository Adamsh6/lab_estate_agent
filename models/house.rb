require('pg')
require('pry')

class House

  attr_accessor :address, :value, :bedroom_num, :buy_let
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @address = options['address']
    @value = options['value'].to_i
    @bedroom_num = options['bedroom_num'].to_i
    @buy_let = options['buy_let']
  end

  def save()

    db = PG.connect({
      dbname: 'estate_agent',
      host: 'localhost'
      })
      sql = "INSERT INTO properties
      (address,
        value,
        bedroom_num,
        buy_let)
        VALUES ($1, $2, $3, $4) RETURNING *"
        values = [@address, @value, @bedroom_num, @buy_let]
        db.prepare("save", sql)
        result = db.exec_prepared("save", values)
        @id = result[0]['id'].to_i

        db.close()
      end

      def update()

        db = PG.connect({
          dbname: 'estate_agent',
          host: 'localhost'
          })
          sql = "UPDATE properties SET (
          address,
          value,
          bedroom_num,
          buy_let) = ($1, $2, $3, $4)
          WHERE id = $5"
          values = [@address, @value, @bedroom_num, @buy_let, @id]
          db.prepare("update", sql)
          db.exec_prepared("update", values)
          db.close
        end

        def delete()

          db = PG.connect({
            dbname: 'estate_agent',
            host: 'localhost'
            })
            sql = "DELETE FROM properties WHERE id = $1"
            values = [@id]
            db.prepare("delete_one", sql)
            db.exec_prepared("delete_one", values)
            db.close()
          end

          def House.all()
            db = PG.connect({
              dbname: 'estate_agent',
              host: 'localhost'
              })
              sql = "SELECT * FROM properties"
              db.prepare("all", sql)
              houses = db.exec_prepared("all")
              db.close
              return houses.map { |house| House.new(house)}
            end

            def House.delete_all()
              db = PG.connect({
                dbname: 'estate_agent',
                host: 'localhost'
                })
                sql = "DELETE FROM properties"
                db.prepare("delete_all", sql)
                db.exec_prepared("delete_all")
                db.close()
              end

              def House.find_by_id(search_id)
                db = PG.connect({
                  dbname: 'estate_agent',
                  host: 'localhost'
                  })
                  sql = "SELECT * FROM properties WHERE id = $1"
                  values = [search_id]
                  db.prepare("find", sql)
                  result = db.exec_prepared("find", values)


                  db.close
                  return nil if result.count == 0
                  return House.new(result[0])
                end

                def House.find_by_address(search_address)
                  db = PG.connect({
                    dbname: 'estate_agent',
                    host: 'localhost'
                    })
                    sql = "SELECT * FROM properties WHERE address = $1"
                    values = [search_address]
                    db.prepare("find_by_a", sql)
                    result = db.exec_prepared("find_by_a", values)

                    db.close
                    return nil if result.count == 0
                    return House.new(result[0])
                  end

                end
