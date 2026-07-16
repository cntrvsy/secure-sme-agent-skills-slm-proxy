<script lang="ts">
	import { Transition } from '@animotion/core'
</script>

<div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-center min-h-[85vh] w-full max-w-7xl mx-auto px-4">
	<!-- Left Side: Narrative Explanation -->
	<div class="lg:col-span-5 flex flex-col justify-center text-left">
		<Transition visible>
			<h2 class="text-4xl font-extrabold tracking-tight mb-2 text-primary">
				Format Integrity Analysis
			</h2>
			<p class="text-xs uppercase tracking-widest text-slate-500 font-bold mb-6">
				Figure 4.2: Format Integrity Pass Rate
			</p>
		</Transition>
		
		<div class="space-y-6 text-base-content/85">
			<Transition delay={0.2} visible>
				<div>
					<h3 class="font-bold text-lg text-base-content">Alignment Generalization</h3>
					<p class="text-sm text-base-content/75 mt-1 font-light leading-relaxed">
						A perfect <strong>100.00% Format Integrity Pass Rate</strong> was achieved by the fine-tuned proxy. Rigid YAML frontmatter and Markdown schemas were successfully generalized as structural constraints.
					</p>
				</div>
			</Transition>

			<Transition delay={0.4} visible>
				<div>
					<h3 class="font-bold text-lg text-base-content">Vanilla Operational Bottleneck</h3>
					<p class="text-sm text-base-content/75 mt-1 font-light leading-relaxed">
						Format failures occurred in <strong>3.25%</strong> of base baseline runs and <strong>3.79%</strong> of enhanced runs (malformed YAML/headers), causing fatal crashes in downstream parsing.
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
					src="/images/format_integrity_chart.png" 
					alt="Format Integrity Chart"
				/>
			</div>
		</Transition>
	</div>
</div>
