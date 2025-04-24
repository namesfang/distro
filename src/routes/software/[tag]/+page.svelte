<script lang="ts">
	import Finder from "$components/finder.svelte";

  let { data } = $props()
</script>

<div class="head">
  <h2>{data.tag?.label}</h2>
  <Finder value={data.keyword}/>
</div>

<div class="softwares">
  <ul>
    {#each [1,2,3,4,5,6] as t}
      <li>
        <div class="brand">
          <div class="wt">
            <i></i>
          </div>
          <div class="md">
            <h2>腾讯QQ</h2>
            <nav>
              <a href="/">下载页面</a>
              <a href="/">应用主页</a>
            </nav>
            <p>这里是描述信息</p>
            <p>最后更新于2024-12-01 12:12:12</p>
          </div>
        </div>
        <div class="">
          
        </div>
      </li>
    {/each}
  </ul>
</div>

<style lang="scss">
  .head {
    height: 64px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 16px;

    h2 {
      font-size: 18px;
    }

    
  }
  .softwares {
    flex: 1;
    flex-shrink: 0;
    padding: 18px;
    overflow: hidden;
    overflow-y: auto;
    ul {
      min-height: 100px;
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
      grid-auto-rows: 168px;
      gap: 12px;
      padding-bottom: 12px;
      li {
        padding: 12px;
        border-radius: 5px;
        border: 1px solid #e8eaf2;
        position: relative;
      }
    }
  }
</style>