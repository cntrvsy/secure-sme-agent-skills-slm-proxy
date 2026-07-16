<script lang="ts">
	import { Transition } from '@animotion/core'
</script>

<div class="flex flex-col items-center justify-center min-h-[80vh] w-full max-w-7xl mx-auto px-4 text-center">
	<Transition visible class="w-full">
		<div class="card bg-base-200 border border-base-300 p-12 shadow-2xl flex flex-col items-center text-center relative overflow-hidden">
			<!-- Subtle background gradient glow -->
			<div class="absolute -top-40 -right-40 w-96 h-96 bg-primary/10 rounded-full blur-3xl"></div>
			<div class="absolute -bottom-40 -left-40 w-96 h-96 bg-secondary/10 rounded-full blur-3xl"></div>

			<!-- Section Header -->
			<Transition delay={0.1} visible>
				<h2 class="text-4xl font-extrabold tracking-tight mb-2 text-primary">
					Conclusions & Future Work
				</h2>
				<p class="text-xs uppercase tracking-widest text-base-content/50 font-semibold mb-8">
					CST7000 Technology Dissertation Summary
				</p>
			</Transition>

			<!-- Highlights Grid -->
			<div class="grid grid-cols-1 md:grid-cols-2 gap-8 w-full max-w-4xl text-left mt-2 mb-8">
				<!-- Left Column: Core Contributions -->
				<Transition delay={0.3} visible>
					<div class="bg-base-300 border border-base-200 p-6 rounded-2xl h-full shadow-inner">
						<h3 class="font-bold text-lg text-base-content mb-3 border-b border-base-content/10 pb-2">
							Key Achievements
						</h3>
						<ul class="space-y-3 text-sm text-base-content/80 font-light">
							<li class="flex items-start gap-2">
								<span class="text-primary font-bold">•</span>
								<span><strong>SME Paradox Resolution:</strong> Local security pipeline runs on lightweight hardware, bypassing heavy server structures.</span>
							</li>
							<li class="flex items-start gap-2">
								<span class="text-primary font-bold">•</span>
								<span><strong>Zero Safety Leakage:</strong> Fine-tuned model achieved 0.00% Attack Success Rate while maintaining 100.00% format pass rate.</span>
							</li>
							<li class="flex items-start gap-2">
								<span class="text-primary font-bold">•</span>
								<span><strong>Context Tax Mitigation:</strong> Stable 1.4x-1.5x token compression ratio without truncating core instruction logic.</span>
							</li>
						</ul>
					</div>
				</Transition>

				<!-- Right Column: Future Directions -->
				<Transition delay={0.5} visible>
					<div class="bg-base-300 border border-base-200 p-6 rounded-2xl h-full shadow-inner">
						<h3 class="font-bold text-lg text-base-content mb-3 border-b border-base-content/10 pb-2">
							Future Scope
						</h3>
						<ul class="space-y-3 text-sm text-base-content/80 font-light">
							<li class="flex items-start gap-2">
								<span class="text-secondary font-bold">→</span>
								<span><strong>Longitudinal Study:</strong> Deploying the proxy in a live, multi-agent SME environment to measure long-term performance.</span>
							</li>
							<li class="flex items-start gap-2">
								<span class="text-secondary font-bold">→</span>
								<span><strong>Dynamic Workspace Auditing:</strong> Extending the validation check to multi-turn execution environments like AgentDojo.</span>
							</li>
							<li class="flex items-start gap-2">
								<span class="text-secondary font-bold">→</span>
								<span><strong>Threat Evolution:</strong> Continuous model alignment against newly discovered zero-day jailbreaks.</span>
							</li>
						</ul>
					</div>
				</Transition>
			</div>

			<!-- Divider -->
			<div class="divider w-24 mx-auto mb-6 bg-gradient-to-r from-primary to-accent h-[2px]"></div>

			<!-- Author End Card -->
			<Transition delay={0.7} visible>
				<h4 class="text-lg font-bold text-base-content">Thank You</h4>
				<p class="text-xs text-base-content/50 mt-1">Questions and Discussion</p>
			</Transition>
		</div>
	</Transition>
</div>
