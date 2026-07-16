<script lang="ts">
	import { Transition } from '@animotion/core'
</script>

<div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-center min-h-[85vh] w-full max-w-7xl mx-auto px-4">
	<!-- Left Side: Narrative Explanation -->
	<div class="lg:col-span-5 flex flex-col justify-center text-left">
		<Transition visible>
			<h2 class="text-4xl font-extrabold tracking-tight mb-2 text-primary">
				Token Compression Analysis
			</h2>
			<p class="text-xs uppercase tracking-widest text-slate-500 font-bold mb-6">
				Figure 4.3: Token Compression Ratio Distribution
			</p>
		</Transition>
		
		<div class="space-y-6 text-base-content/85">
			<Transition delay={0.2} visible>
				<div>
					<h3 class="font-bold text-lg text-base-content">Stable Compression Boundaries</h3>
					<p class="text-sm text-base-content/75 mt-1 font-light leading-relaxed">
						The fine-tuned proxy maintains a consistent, stable compression range between <strong>1.14x and 1.53x</strong>. This narrow distribution confirms that structural metadata and functional parameters are systematically preserved.
					</p>
				</div>
			</Transition>

			<Transition delay={0.4} visible>
				<div>
					<h3 class="font-bold text-lg text-base-content">Baseline Compression Flaws</h3>
					<p class="text-sm text-base-content/75 mt-1 font-light leading-relaxed">
						The vanilla model shows erratic, highly variable compression ratios clustered between <strong>4.0x and 6.0x</strong>. This suggests severe text deletion rather than useful semantic distillation.
					</p>
				</div>
			</Transition>
		</div>
	</div>

	<!-- Right Side: Graphic Viewer directly (no mockup-window) -->
	<div class="lg:col-span-7 flex flex-col justify-center items-center">
		<Transition visible class="w-full">
			<div class="flex items-center justify-center h-[500px] w-full relative">
				<img 
					class="max-h-[480px] max-w-full object-contain rounded-2xl border border-base-300 shadow-2xl relative z-10 p-2 bg-base-200/50" 
					src="/images/compression_ratio_boxplot.png" 
					alt="Token Compression Ratio Distribution"
				/>
			</div>
		</Transition>
	</div>
</div>
