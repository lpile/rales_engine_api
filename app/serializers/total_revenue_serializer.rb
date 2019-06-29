class TotalRevenueSerializer
  include FastJsonapi::ObjectSerializer

  attribute :total_revenue do |object|
    '%.2f' % (object.total_revenue)
  end
end
