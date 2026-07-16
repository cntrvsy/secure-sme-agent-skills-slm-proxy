<script lang="ts">
	import { Transition } from '@animotion/core'
</script>

<div class="flex flex-col items-center justify-center min-h-[80vh] w-full max-w-7xl mx-auto px-4 text-center">
	<Transition visible>
		<h2 class="text-5xl font-extrabold tracking-tight mb-3 text-primary">
			Proxy Architecture & Hardware Footprint
		</h2>
		<p class="text-base-content/80 font-light mb-12 max-w-2xl mx-auto text-lg">
			Quantized local deployment allows SMEs to secure integrations without massive infrastructure costs.
		</p>
	</Transition>

	<!-- Stats Grid -->
	<Transition delay={0.2} visible class="w-full">
		<div class="stats stats-vertical lg:stats-horizontal shadow border border-base-300 bg-base-200 w-full mb-8">
			<div class="stat p-8">
				<div class="stat-title text-xs uppercase tracking-wider mb-2">Base Model</div>
				<div class="stat-value text-3xl text-primary font-bold">Qwen2.5-3B-Instruct</div>
				<div class="stat-desc text-xs text-base-content/50 mt-1">Dense 3-billion parameter model</div>
			</div>
			
			<div class="stat p-8">
				<div class="stat-title text-xs uppercase tracking-wider mb-2">Quantization Precision</div>
				<div class="stat-value text-3xl text-secondary font-bold">4-bit GGUF</div>
				<div class="stat-desc text-xs text-base-content/50 mt-1">Compressed model size: ~1.9 GB</div>
			</div>
			
			<div class="stat p-8">
				<div class="stat-title text-xs uppercase tracking-wider mb-2">Hardware Target</div>
				<div class="stat-value text-3xl text-accent font-bold">4 to 6 GB VRAM</div>
				<div class="stat-desc text-xs text-base-content/50 mt-1">Runs locally on entry-level consumer GPUs</div>
			</div>
		</div>
	</Transition>

	<!-- Additional Specs list -->
	<div class="grid grid-cols-1 md:grid-cols-2 gap-8 w-full max-w-4xl text-left mt-2">
		<Transition delay={0.4} visible>
			<div class="bg-base-300/40 p-5 border border-base-250 rounded-xl">
				<h4 class="font-bold text-sm text-base-content mb-1">Local Deployment Benefits</h4>
				<p class="text-xs text-base-content/70 font-light leading-relaxed">
					Bypasses API token costs and latency bottlenecks. Ensures that sensitive SME company directories and proprietary tool schemas are never transmitted to third-party model providers.
				</p>
			</div>
		</Transition>

		<Transition delay={0.6} visible>
			<div class="bg-base-300/40 p-5 border border-base-250 rounded-xl">
				<h4 class="font-bold text-sm text-base-content mb-1">Instruction Tuned Focus</h4>
				<p class="text-xs text-base-content/70 font-light leading-relaxed">
					The model is aligned to execute a single task: read a file, strip indirect injections, and compress formatting. This specialized focus enables 3B models to outperform 175B general models.
				</p>
			</div>
		</Transition>
	</div>
</div>
