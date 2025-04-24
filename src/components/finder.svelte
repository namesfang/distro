<script lang="ts">
	import Search from "$components/icons/search.svelte";

  let { value = $bindable() } = $props()

</script>

<form>
  <input autocomplete="off" name="keyword" {value} placeholder="软件名称"/>
  <button type="submit">
    <Search/>
  </button>
</form>

<style lang="scss">
  form {
    display: block;
    position: relative;
    input {
      width: 320px;
      height: 42px;
      font-size: 14px;
      padding: 0 12px;
      border-radius: 12px;
      outline: none;
      border: 1px solid #f1f1f1;
      position: relative;
      z-index: 0;

      &:focus {
        border-color: var(--primary-color);
        outline: 3px solid var(--hover-primary-color);
        &+button {
          color: var(--text-color);
        }
      }
    }
    button {
      width: 42px;
      height: 42px;
      display: inline-flex;
      align-items: center;
      justify-content: center;
      color: var(--text-2-color);
      position: absolute;
      right: 0;
      top: 1px;
      border: 1px;
      background-color: transparent;
      z-index: 99;
      border-radius: 12px;
      &:active {
        font-size: 16px;
        background-color: var(--hover-background-color);
      }
    }
  }
</style>