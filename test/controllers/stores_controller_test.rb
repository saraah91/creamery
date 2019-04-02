require 'test_helper'

class StoresControllerTest < ActionDispatch::IntegrationTest
    setup do
      create_contexts
      #@store = stores(:one)
    end

    teardown do
      remove_contexts
    end

  test "should get index" do
    get stores_url
    assert_response :success
  end
  
  test "should get active" do
    get active_stores_url
    assert_response :success
  end
  
  test "should get inactive" do
    get inactive_stores_url
    assert_response :success
  end

  test "should get new" do
    get new_store_url
    assert_response :success
  end

  test "should create store" do
    assert_difference('Store.count') do
      post stores_url, params: { store: { active: @store.active, city: @store.city, latitude: @store.latitude, longitude: @store.longitude, name: @store.name, phone: @store.phone, state: @store.state, street: @store.street, zip: @store.zip } }
    end

    assert_redirected_to store_url(Store.last)
  end

  test "should show store" do
    get store_url(@store)
    assert_response :success
  end

  test "should get edit" do
    get edit_store_url(@store)
    assert_response :success
  end

  test "should update store" do
    patch store_url(@store), params: { store: { active: @store.active, city: @store.city, latitude: @store.latitude, longitude: @store.longitude, name: @store.name, phone: @store.phone, state: @store.state, street: @store.street, zip: @store.zip } }
    assert_redirected_to store_url(@store)
  end

  test "should destroy store" do
    assert_difference('Store.count', -1) do
      delete store_url(@store)
    end

    assert_redirected_to stores_url
  end
end
