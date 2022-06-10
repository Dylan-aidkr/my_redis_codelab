
defmodule MyRedisAgent do
    use Agent
    # 아래와 같은 API 를 가지는 MyRedis 를 GenServer 기반으로 구현하세요.
    # mix test 를 통과하면 구현이 완료된 것입니다.
  
    def start_link() do
        Agent.start_link(fn -> Map.new() end)
    end
  
    def get(pid, key) do
        Agent.get(pid, &do_get(&1, key))
    end
  
    def set(pid, key, value) do
        Agent.update(pid, &do_set(&1, key, value))
    end
  
    def delete(pid, key) do
        Agent.update(pid, &do_delete(&1, key))
    end

    defp do_get(mem, key) do
        mem |> Map.fetch(key)
    end

    defp do_set(mem, key, value) do
        mem |> Map.put(key, value)
    end

    defp do_delete(mem, key) do
        mem |> Map.delete(key)
    end

  end
  