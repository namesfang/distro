<script lang="ts">
  import * as Components from '$components/icons'

  interface Props extends icons.Props {
    name: icons.Name
  }

  const props: Props = $props()

  const name = $derived.by(()=> props.name.split('-').map(t=> t.substring(0, 1).toUpperCase() + t.substring(1)).join('') as icons.Name)
  
  let Component = $derived.by(()=> Components[name])
</script>

<Component {...props}/>

