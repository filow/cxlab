require 'test_helper'

class Manage::StudentTest < ActiveSupport::TestCase
  test 'stuid不能重复' do
    existed_student = students(:user1)
    test_student = Student.new(stuid: existed_student.stuid, name: 'test_name',pwd: '12345678')
    assert_not test_student.save
  end

  test 'stuid应为10位数字' do
    # 数字情况
    (0..15).each do |x|
      str = random_string(length: x,number: true)
      student = Student.new(stuid: str, name: 'test_name',pwd: '12345678')
      student.save
      if x != 10
        assert_nil student.id
      else
        assert_not_nil student.id
      end
    end

    # 字母情况
    (8..13).each do |x|
      str = random_string(length: x)
      student = Student.new(stuid: str, name: 'test_name',pwd: '12345678')
      student.save
      assert_nil student.id
    end
  end

  test '名字必须存在' do
    student = Student.new(stuid: '1206030207',name:'',pwd: '12345678')
    student.save
    assert_nil student.id

    student.name = 'test_name'
    student.save
    assert_not_nil student
  end

  test '密码至少8位' do
    (6..10).each do |x|
      student = Student.new(stuid: random_string(length: 10,number: true),name:'test_name')
      student.pwd = random_string(length: x)

      student.save
      if x < 8
        assert_nil student.id
      else
        assert_not_nil student.id
      end
      student.destroy
    end
  end

  test '检测email格式' do
    valid = %w(fiergb@rge.com 44123jgerge@3412ef.com 241jgr@r.cc 213@hhu.edu.cn grehg@4214.edu)
    invalid = %w(8394u12j rhu43.com 423@rge ger4@.com @efw.com 423jg@)
    student = students(:user1)
    valid.each do |e|
      student.email = e
      assert student.save
    end

    invalid.each do |e|
      student.email = e
      assert_not student.save
    end
  end

  test '检测账号密码校验' do
    student = students(:user1)
    student.pwd = '12345678'
    student.save

    # 正确的情况
    s = Student.auth(student.stuid, '12345678')
    assert_equal s, student

    # 错误的情况
    s = Student.auth(student.stuid, '123')
    assert_nil s
  end

end
