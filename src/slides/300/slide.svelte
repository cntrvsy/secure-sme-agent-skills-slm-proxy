<script lang="ts">
	import { Transition } from '@animotion/core'
</script>

<div class="flex flex-col items-center justify-center min-h-[80vh] w-full max-w-7xl mx-auto px-4 text-center">
	<Transition visible>
		<h2 class="text-5xl font-extrabold tracking-tight mb-3 text-primary">
			The Attack Pipeline
		</h2>
		<p class="text-base-content/80 font-light mb-12 max-w-2xl mx-auto text-lg">
			How natural language instructions bypass security boundaries to compromise tool execution.
		</p>
	</Transition>

	<!-- Horizontal Steps -->
	<div class="grid grid-cols-1 md:grid-cols-3 gap-6 w-full text-left mt-2">
		<!-- Step 1 -->
		<Transition delay={0.2} visible>
			<div class="card bg-base-200 border border-base-300 shadow-xl p-8 relative overflow-hidden h-full flex flex-col justify-between">
				<div>
					<div class="text-xs uppercase tracking-widest text-primary font-bold mb-4">Stage 1</div>
					<h3 class="font-bold text-xl text-base-content mb-3">
						Payload Delivery
					</h3>
					<p class="text-sm text-base-content/75 font-light leading-relaxed">
						The attacker uploads a poisoned payload disguised as benign text (e.g. inside product reviews or static skill files). Since the text looks like normal descriptive data, standard input filters let it pass.
					</p>
				</div>
				<div class="mt-6 text-xs font-mono text-error">
					Threat: Data Poisoning
				</div>
			</div>
		</Transition>

		<!-- Step 2 -->
		<Transition delay={0.4} visible>
			<div class="card bg-base-200 border border-base-300 shadow-xl p-8 relative overflow-hidden h-full flex flex-col justify-between">
				<div>
					<div class="text-xs uppercase tracking-widest text-secondary font-bold mb-4">Stage 2</div>
					<h3 class="font-bold text-xl text-base-content mb-3">
						Context Loading
					</h3>
					<p class="text-sm text-base-content/75 font-light leading-relaxed">
						The downstream agent executes a command that requires reading the skill description. The raw text payload is dynamically loaded directly into the active prompt context.
					</p>
				</div>
				<div class="mt-6 text-xs font-mono text-warning">
					Threat: Context Ingestion
				</div>
			</div>
		</Transition>

		<!-- Step 3 -->
		<Transition delay={0.6} visible>
			<div class="card bg-base-200 border border-base-300 shadow-xl p-8 relative overflow-hidden h-full flex flex-col justify-between">
				<div>
					<div class="text-xs uppercase tracking-widest text-accent font-bold mb-4">Stage 3</div>
					<h3 class="font-bold text-xl text-base-content mb-3">
						Exploit Execution
					</h3>
					<p class="text-sm text-base-content/75 font-light leading-relaxed">
						The language model fails to separate commands from data. It interprets the attacker instructions as system directives and executes malicious APIs to exfiltrate private credentials.
					</p>
				</div>
				<div class="mt-6 text-xs font-mono text-success">
					Result: Confused Deputy
				</div>
			</div>
		</Transition>
	</div>
</div>
