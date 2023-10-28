<script lang="ts">
	import { QueryClient, QueryClientProvider } from '@sveltestack/svelte-query';
	import { locale, loadTranslations } from '../lib/translations';
	import '../styles/global.css';

	// load the proper translation file based on the uri.
	export const load = async ({ url }) => {
		const { pathname } = url;

		// the default locale is always english
		const defaultLocale = 'en';

		// we check for the user's preferred locale before defaulting
		const initLocale = locale.get() || defaultLocale;

		// load our translations on the server side
		await loadTranslations(initLocale, pathname);

		return {};
	};

	// our svelte-query client
	// this is the client that does all of our data-fetching
	const queryClient = new QueryClient();
</script>

<!-- the query client provider gives our svelte -->
<!-- application a shared context to store the  -->
<!-- data we fetch using svelte-query.          -->
<QueryClientProvider client={queryClient}>
	<slot />
</QueryClientProvider>
