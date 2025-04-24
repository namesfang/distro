<script lang="ts">
	import Icon from "$components/icons/icon.svelte";
  
  let { children, data } = $props()

	const className = $derived.by(()=> `container linear-${Math.floor(Math.random() * 6)}`)
</script>

<svelte:head>
	<title>国产Linux软件整理</title>
	<script>
	// var _hmt = _hmt || [];
	// (function() {
	// 	var hm = document.createElement("script");
	// 	hm.src = "https://hm.baidu.com/hm.js?f5c4333a8d378a5fdd4e8f44da4e770c";
	// 	var s = document.getElementsByTagName("script")[0]; 
	// 	s.parentNode.insertBefore(hm, s);
	// })();
	</script>
</svelte:head>

<div class={className}>
	<aside>
		{#each data.multi as items}
			<nav>
				{#each items as {active, href, icon, label, target}}
					<a href={href} class:active={active} {target}>
						<i>
							<Icon name={icon}/>
						</i>
						<em>{label}</em>
					</a>
				{/each}
			</nav>
		{/each}
	</aside>
	<main>
		{@render children()}
	</main>
</div>


<style lang="scss">
  .container {
    height: 100vh;
    background-color: #1A202C;
    background-image: linear-gradient(45deg, var(--start) 0, var(--end) 100%);
		display: flex;

		aside {
			width: 48px;
			display: flex;
			flex-direction: column;
			justify-content: space-between;
			position: relative;
			margin: 24px 12px;

			nav {
				a {
					width: 48px;
					height: 68px;
					color: rgb(255, 255, 255, .8);
					display: inline-flex;
					flex-direction: column;
					align-items: center;
					justify-content: center;
					margin-bottom: 28px;
					position: relative;
					transition-duration: 0.2s;
					&:last-child {
						margin-bottom: 0;
					}

					i {
						width: 48px;
						height: 48px;
						font-size: 26px;
						display: inline-flex;
						align-items: center;
						justify-content: center;
					}

					em {
						font-size: 12px;
						font-style: normal;
						line-height: 18px;
						margin-top: 2px;
					}
				}
			}
			.active {
				color: #fff;
				transform: translateY(2px);
				i {
					background-color: rgba(255, 255, 255, 0.2);
					color: rgb(255, 255, 255);
					border-radius: 50%;
				}
				em {
					color: #fff;
				}
			}
		}

		main {
			background-color: rgb(255, 255, 255);
			flex: 1 1 0%;
			overflow: hidden auto;
			margin: 8px 8px 8px 0px;
    	border-radius: 12px;
			display: flex;
		}
  }
  .linear-0 {
    --start: #374FC7;
    --end: #23BA99;
  }
  .linear-1 {
    --start: #6B4BCC;
    --end: #F2323F;
  }
  .linear-2 {
    --start: #F2323F;
    --end: #F76F34;
  }
  .linear-3 {
    --start: #374FC7;
    --end: #6B4BCC;
  }
  .linear-4 {
    --start: #374FC7;
    --end: #6B4BCC;
  }
  .linear-5 {
    --start: #6B4BCC;
    --end: #3DBA4E;
  }
  .linear-6 {
    --start: #D5D7DB;
    --end: #F8F9FA;
  }
</style>