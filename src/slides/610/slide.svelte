<script lang="ts">
	import { Transition } from '@animotion/core'
</script>

<div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-center min-h-[85vh] w-full max-w-7xl mx-auto px-4">
	<!-- Left Side: Narrative Explanation -->
	<div class="lg:col-span-5 flex flex-col justify-center text-left">
		<Transition visible>
			<h2 class="text-4xl font-extrabold tracking-tight mb-2 text-primary">
				Security Efficacy Analysis
			</h2>
			<p class="text-xs uppercase tracking-widest text-slate-500 font-bold mb-6">
				Figure 4.1: Security Efficacy Matrix
			</p>
		</Transition>
		
		<div class="space-y-6 text-base-content/85">
			<Transition delay={0.2} visible>
				<div>
					<h3 class="font-bold text-lg text-base-content">Defensive Safety Efficacy</h3>
					<p class="text-sm text-base-content/75 mt-1 font-light leading-relaxed">
						A <strong>0.00% Attack Success Rate (ASR-valid)</strong> was achieved by the fine-tuned proxy under both standard (Base) and jailbreak-enhanced (Enhanced) attack scenarios, neutralizing all adversarial payloads.
					</p>
				</div>
			</Transition>

			<Transition delay={0.4} visible>
				<div>
					<h3 class="font-bold text-lg text-base-content">Baseline Vulnerabilities & False Alarms</h3>
					<p class="text-sm text-base-content/75 mt-1 font-light leading-relaxed">
						The vanilla model suffered a <strong>3.38% ASR-valid</strong> under standard attacks and <strong>2.24%</strong> under jailbreak configurations. Furthermore, the proxy reduced false alarms to <strong>0.00%</strong> (compared to the baseline's <strong>3.33%</strong>).
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
					src="/images/security_efficacy_matrix.png" 
					alt="Security Efficacy Matrix"
				/>
			</div>
		</Transition>
	</div>
</div>
