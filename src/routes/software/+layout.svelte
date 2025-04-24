<script lang="ts">
	import Icon from '$components/icons/icon.svelte';

  let { data, children } = $props()
</script>

<div class="west">
  <h2>软件分类</h2>
  <div class="tags">
    <ul>
      {#each data.tags as {icon, label, href}}
        <li>
          <a href={href} class:active={data.pathname === href}>
            <i>
              <Icon fill={data.pathname === href} small name={icon as icons.Name}/>
            </i>
            <em>{label}</em>
          </a>
        </li>
      {/each}
    </ul>
  </div>
</div>
<div class="content">
  {@render children()}
</div>

<style lang="scss">
  .west {
    width: 150px;
    height: auto;
    overflow: hidden;
    display: flex;
    flex-direction: column;
    position: relative;
    padding: 12px 0;
    background-color: #fff;
    border-right: 1px solid rgba(237, 239, 245, .45);

    h2 {
      padding: 0 16px;
      margin-bottom: 12px;
      font-size: 14px;
      font-weight: 700;
      color: var(--text-color);
    }

    .tags {
      flex: 1;
      overflow: hidden;
      overflow-y: auto;

      ul {
        li {
          display: flex;
          align-items: center;
          padding: 0 16px;
          a {
            width: 100px;
            display: inline-flex;
            align-items: center;
            padding: 8px 16px;
            border-radius: 12px;
            i {
              width: 26px;
              height: 26px;
              display: inline-flex;
              justify-content: flex-start;
              align-items: center;
            }
            em {
              font-style: normal;
              font-size: 14px;
            }
          }

          .active {
            background-color: var(--primary-color);
            color: #fff;
            em {
              font-weight: bold;
            }
          }
        }
      }
    }

  }
  .content {
    flex: 1;
    display: flex;
    flex-direction: column;
  }
</style>