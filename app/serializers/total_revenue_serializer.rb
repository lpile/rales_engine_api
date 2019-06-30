class TotalRevenueSerializer
  include FastJsonapi::ObjectSerializer

  attribute :total_revenue do |object|
    (object.total_revenue / 100.0).to_s
  end
end
