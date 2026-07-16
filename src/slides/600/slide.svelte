<script lang="ts">
	import { Transition } from '@animotion/core'
</script>

<div class="grid grid-cols-1 lg:grid-cols-12 gap-8 items-center min-h-[85vh] w-full max-w-7xl mx-auto px-4">
	<!-- Left Side: Narrative Explanation -->
	<div class="lg:col-span-5 flex flex-col justify-center text-left">
		<Transition visible>
			<h2 class="text-4xl font-extrabold tracking-tight mb-6 text-primary">
				The Security by Destruction Trap
			</h2>
		</Transition>
		
		<div class="space-y-6 text-base-content/85">
			<Transition delay={0.2} visible>
				<div>
					<h3 class="font-bold text-lg text-base-content">The Illusion of Performance</h3>
					<p class="text-sm text-base-content/75 mt-1 font-light leading-relaxed">
						Standard baseline models appear to compress token sizes extremely well. However, they achieve safety simply by truncating all text, discarding functional directives and leaving downstream agents useless.
					</p>
				</div>
			</Transition>

			<Transition delay={0.4} visible>
				<div>
					<h3 class="font-bold text-lg text-base-content">Usability Alignment</h3>
					<p class="text-sm text-base-content/75 mt-1 font-light leading-relaxed">
						The fine-tuned model achieves a balance: it neutralizes injections (0.00% Attack Success Rate) while retaining complete format configuration (100.00% Pass Rate) and technical definitions.
					</p>
				</div>
			</Transition>
		</div>
	</div>

	<!-- Right Side: Large Focused Comparison Table -->
	<div class="lg:col-span-7 flex flex-col justify-center">
		<Transition delay={0.6} visible class="w-full">
			<div class="card bg-base-200 border border-base-300 p-8 shadow-2xl w-full text-left">
				<h3 class="text-xs uppercase tracking-widest text-secondary font-bold mb-4">Model Performance Matrix</h3>
				
				<div class="overflow-x-auto">
					<table class="table table-sm w-full text-left">
						<thead>
							<tr class="border-b border-base-300 text-base-content/60">
								<th>Model Configuration</th>
								<th>Format Pass</th>
								<th>Safety Vulnerability</th>
								<th>Avg. Compression</th>
							</tr>
						</thead>
						<tbody class="divide-y divide-base-300 text-base-content/90">
							<tr class="hover:bg-base-300/30">
								<td class="font-bold text-primary">Fine-Tuned Proxy</td>
								<td><span class="badge badge-success badge-sm font-semibold">100.00%</span></td>
								<td><span class="badge badge-success badge-sm font-semibold">0.00% ASR</span></td>
								<td class="font-mono text-xs">1.39x - 1.53x</td>
							</tr>
							<tr class="hover:bg-base-300/30">
								<td class="font-bold text-slate-400">Vanilla Baseline</td>
								<td><span class="badge badge-warning badge-sm font-semibold">96.21%</span></td>
								<td><span class="badge badge-error badge-sm font-semibold text-white">3.38% ASR</span></td>
								<td class="font-mono text-xs text-secondary">4.69x - 5.08x</td>
							</tr>
						</tbody>
					</table>
				</div>

				<div class="mt-8 border-t border-base-300/50 pt-4 text-xs text-base-content/60 leading-relaxed space-y-1 font-light">
					<p><strong>Standard Mode Evaluations:</strong> Measured against a holdout test split of 1,198 virtual instances.</p>
					<p><strong>False-Alarm Rate (benign negatives):</strong> Fine-Tuned = 0.00%, Vanilla Baseline = 3.33%.</p>
				</div>
			</div>
		</Transition>
	</div>
</div>
