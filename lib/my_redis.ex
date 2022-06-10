
defmodule MyRedis do
  use GenServer
  # 아래와 같은 API 를 가지는 MyRedis 를 GenServer 기반으로 구현하세요.
  # mix test 를 통과하면 구현이 완료된 것입니다.

  def start_link() do
    # GenServer.start_link(MyRedis, Map.new())
    GenServer.start_link(__MODULE__, Map.new())
  end

  def get(pid, key) do
    GenServer.call(pid, {:get, key})
  end

  def set(pid, key, value) do
    GenServer.cast(pid, {:set, key, value})
  end

  def delete(pid, key) do
    GenServer.cast(pid, {:delete, key})
  end

  def init(init_mem) do
      {:ok, init_mem}
  end

  def handle_call({:get, key} , _from, mem ) do
      { :reply, mem |> Map.fetch(key), mem }
  end

  def handle_cast({:set, key, value}, mem ) do
      {:noreply, mem |> Map.put(key, value) }
  end

  def handle_cast({:delete, key}, mem) do
      {:noreply, mem |> Map.delete(key)}
  end
end
