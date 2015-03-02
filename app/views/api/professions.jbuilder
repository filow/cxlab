json.array! @professions do |cate|
    json.extract! cate,:id,:name
    json.child cate.child do |profession|
        json.(profession,:id,:name)
    end
end
