defmodule MyRedisAgentTest do
  use ExUnit.Case

  setup do
    {:ok, redis} = MyRedisAgent.start_link()
    %{redis: redis}
  end

  test "single", %{redis: redis} do
    # before set
    assert :error == MyRedisAgent.get(redis, :foo)

    # set
    assert :ok == MyRedisAgent.set(redis, :foo, :bar)
    assert {:ok, :bar} == MyRedisAgent.get(redis, :foo)
    assert {:ok, :bar} == MyRedisAgent.get(redis, :foo)

    # delete
    assert :ok == MyRedisAgent.delete(redis, :foo)
    assert :error == MyRedisAgent.get(redis, :foo)
  end

  test "nil is not error", %{redis: redis} do
    # before set
    assert :error == MyRedisAgent.get(redis, :foo)

    # set
    assert :ok == MyRedisAgent.set(redis, :foo, nil)
    assert {:ok, nil} == MyRedisAgent.get(redis, :foo)

    # delete
    assert :ok == MyRedisAgent.delete(redis, :foo)
    assert :error == MyRedisAgent.get(redis, :foo)
  end

  test "multiple", %{redis: redis} do
    # set
    assert :ok == MyRedisAgent.set(redis, :k1, :v1)
    assert :ok == MyRedisAgent.set(redis, :k2, :v2)
    assert :ok == MyRedisAgent.set(redis, :k3, :v3)
    # get
    assert {:ok, :v1} == MyRedisAgent.get(redis, :k1)
    assert {:ok, :v2} == MyRedisAgent.get(redis, :k2)
    assert {:ok, :v3} == MyRedisAgent.get(redis, :k3)
    # delete
    assert :ok == MyRedisAgent.delete(redis, :k1)
    assert :ok == MyRedisAgent.delete(redis, :k2)
    assert :ok == MyRedisAgent.delete(redis, :k3)
    # get
    assert :error == MyRedisAgent.get(redis, :k1)
    assert :error == MyRedisAgent.get(redis, :k2)
    assert :error == MyRedisAgent.get(redis, :k3)
  end
end
