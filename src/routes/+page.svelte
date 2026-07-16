<script lang="ts">
	import { Presentation, Slides } from '@animotion/core'
</script>

<Presentation options={{ 
	history: true, 
	transition: 'slide', 
	controls: true, 
	progress: true,
	width: 1280,
	height: 720,
	margin: 0.05,
	minScale: 0.2,
	maxScale: 2.0
}}>
	<Slides center={true} />
</Presentation>
