<script lang="ts">
	import { Transition } from '@animotion/core'
</script>

<div class="flex flex-col items-center justify-center min-h-[80vh] w-full max-w-7xl mx-auto px-4 text-center">
	<Transition visible>
		<h2 class="text-5xl font-extrabold tracking-tight mb-3 text-primary">
			The SME Operational Paradox
		</h2>
		<p class="text-base-content/80 font-light mb-12 max-w-2xl mx-auto text-lg">
			The structural conflict between digital transformation demands and physical resource realities.
		</p>
	</Transition>

	<!-- Row of Cards -->
	<div class="grid grid-cols-1 md:grid-cols-3 gap-6 w-full text-left mt-2">
		<!-- Card 1 -->
		<Transition delay={0.2} visible>
			<div class="card bg-base-200 border border-base-300 shadow-xl p-8 h-full flex flex-col justify-between">
				<div>
					<h3 class="font-bold text-xl text-base-content mb-4 pb-2 border-b border-base-content/10">
						The Imperative
					</h3>
					<p class="text-sm text-base-content/75 font-light leading-relaxed">
						To scale and remain competitive in an increasingly automated economy, small and medium enterprises must incorporate AI agents into their day-to-day business operations.
					</p>
				</div>
				<div class="text-xs uppercase font-semibold text-primary/70 tracking-wider mt-6">
					Goal: Productivity
				</div>
			</div>
		</Transition>

		<!-- Card 2 -->
		<Transition delay={0.4} visible>
			<div class="card bg-base-200 border border-base-300 shadow-xl p-8 h-full flex flex-col justify-between">
				<div>
					<h3 class="font-bold text-xl text-base-content mb-4 pb-2 border-b border-base-content/10">
						The Barrier
					</h3>
					<p class="text-sm text-base-content/75 font-light leading-relaxed">
						Sophisticated tool-calling architectures like the Model Context Protocol require dedicated server management, constant IT supervision, and security grids that SMEs cannot afford.
					</p>
				</div>
				<div class="text-xs uppercase font-semibold text-secondary/70 tracking-wider mt-6">
					Constraint: Infrastructure
				</div>
			</div>
		</Transition>

		<!-- Card 3 -->
		<Transition delay={0.6} visible>
			<div class="card bg-base-200 border border-base-300 shadow-xl p-8 h-full flex flex-col justify-between">
				<div>
					<h3 class="font-bold text-xl text-base-content mb-4 pb-2 border-b border-base-content/10">
						The Compromise
					</h3>
					<p class="text-sm text-base-content/75 font-light leading-relaxed">
						Instead, they embrace Agent Skills. These are local, file-based directories anchored by a static markdown document. They deliver capabilities with zero server configuration.
					</p>
				</div>
				<div class="text-xs uppercase font-semibold text-accent/70 tracking-wider mt-6">
					Alternative: Agent Skills
				</div>
			</div>
		</Transition>
	</div>
</div>
