import adapter from '@sveltejs/adapter-vercel';
import preprocess from 'svelte-preprocess';

/** @type {import('@sveltejs/kit').Config} */
const config = {
	// Consult https://github.com/sveltejs/svelte-preprocess
	// for more information about preprocessors
	preprocess: preprocess({
		postcss: true,
		preserve: ['ld+json']
	}),
	kit: {
		adapter: adapter({
			external: [],
			split: false
		}),
		csp: {
			directives: {
				'script-src': ['vitals.vercel-insights.com', 'self']
			},
			reportOnly: {}
		}
	}
};

export default config;
