<script lang="ts">
	import { Transition } from '@animotion/core'
</script>

<div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-center min-h-[85vh] w-full max-w-7xl mx-auto px-4">
	<!-- Left Side: Narrative Explanation -->
	<div class="lg:col-span-5 flex flex-col justify-center text-left">
		<Transition visible>
			<h2 class="text-4xl font-extrabold tracking-tight mb-2 text-primary">
				The Truncation Illusion
			</h2>
			<p class="text-xs uppercase tracking-widest text-slate-500 font-bold mb-6">
				Figure 4.4: Output vs. Input Length Scaling
			</p>
		</Transition>
		
		<div class="space-y-6 text-base-content/85">
			<Transition delay={0.2} visible>
				<div>
					<h3 class="font-bold text-lg text-base-content">Proportional Scaling</h3>
					<p class="text-sm text-base-content/75 mt-1 font-light leading-relaxed">
						The fine-tuned proxy's output size scales proportionally with input size, remaining close to the 1:1 parity line. This confirms it does real semantic distillation without destroying instruction logic.
					</p>
				</div>
			</Transition>

			<Transition delay={0.4} visible>
				<div>
					<h3 class="font-bold text-lg text-base-content">Destructive Baseline Truncation</h3>
					<p class="text-sm text-base-content/75 mt-1 font-light leading-relaxed">
						The vanilla baseline suffers from the "truncation illusion"—it hard-caps output lengths between <strong>15 and 35 tokens</strong> regardless of input size, deleting critical descriptions and parameters.
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
					src="/images/truncation_illusion_scatter.png" 
					alt="Output vs. Input Length Scaling"
				/>
			</div>
		</Transition>
	</div>
</div>
