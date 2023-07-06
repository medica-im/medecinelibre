<script lang='ts'>
		import Fa from 'svelte-fa';
	import {
		faTwitter,
		faFacebook,
		faLinkedin,
		faInstagram,
		faYoutube,
		faSkype,
        faGithub,
        faMastodon,
	} from '@fortawesome/free-brands-svg-icons';
	import {
		faCircleNodes,
		faBars,
		faCaretDown,
		faHome,
		faBook,
		faBullhorn,
		faPalette,
		faMagnifyingGlass,
		faArrowRight,
		faPhone,
		faEnvelope
	} from '@fortawesome/free-solid-svg-icons';
    	import { page } from '$app/stores';
</script>

<svelte:head>
		<title>
			Contact - {import.meta.env.VITE_SITE_TITLE}
		</title>
</svelte:head>

<div class="container mx-auto p-4 space-y-4">
	<header>
		<h1 class="h1">Contact</h1>
    </header>
	<div class="space-y-4 w-fit">
		<nav class="list-nav underline">
			<ul>
				<li>
					<a href="tel:+33977215435">
						<span class="badge variant-filled-primary"><Fa icon={faPhone} /></span>

						<span class="flex flex-wrap whitespace-normal text-left">09 77 21 54 35</span></a
					>
				</li>
				<li>
					<a href="mailto:info@medecinelibre.com"
						><span class="badge variant-filled-primary"><Fa icon={faEnvelope} /></span>

						<span class="flex flex-wrap whitespace-normal text-left">info@medecinelibre.com</span></a
					>
				</li>
				<li>
					<a href="https://mastodon.medica.im/@medecinelibre"
					title="@medecinelibre@mastodon.medica.im"
						><span class="badge variant-filled-primary"><Fa icon={faMastodon} /></span>

						<span class="flex flex-wrap whitespace-normal text-left">@medecinelibre</span
						></a
					>
				</li>
				<li>
					<a href="https://twitter.com/MedecineLibre"
					title="@MedecineLibre"
						><span class="badge variant-filled-primary"><Fa icon={faTwitter} /></span>

						<span class="flex flex-wrap whitespace-normal text-left">@MedecineLibre</span
						></a
					>
				</li>
				<li>
					<a href="https://www.linkedin.com/in/j%C3%A9r%C3%B4me-pinguet-177454b0/"
						><span class="badge variant-filled-primary"><Fa icon={faLinkedin} /></span>

						<span class="flex flex-wrap whitespace-normal text-left"
							>LinkedIn</span
						></a
					>
				</li>
			</ul>
		</nav>
		</div>
</div>