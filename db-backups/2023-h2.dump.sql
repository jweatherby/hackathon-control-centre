--
-- PostgreSQL database dump
--

-- Dumped from database version 15.3 (Debian 15.3-1.pgdg120+1)
-- Dumped by pg_dump version 15.5 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: AppControlType; Type: TYPE; Schema: public; Owner: hackathon_command_centre
--

CREATE TYPE public."AppControlType" AS ENUM (
    'VOTING_ENABLED',
    'QUESTION',
    'EMBED',
    'IMAGE'
);


ALTER TYPE public."AppControlType" OWNER TO hackathon_command_centre;

--
-- Name: VotingType; Type: TYPE; Schema: public; Owner: hackathon_command_centre
--

CREATE TYPE public."VotingType" AS ENUM (
    'DISTRIBUTE_VOTES',
    'SINGLE_VOTE'
);


ALTER TYPE public."VotingType" OWNER TO hackathon_command_centre;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: AdminUser; Type: TABLE; Schema: public; Owner: hackathon_command_centre
--

CREATE TABLE public."AdminUser" (
    "user" text NOT NULL
);


ALTER TABLE public."AdminUser" OWNER TO hackathon_command_centre;

--
-- Name: AppControl; Type: TABLE; Schema: public; Owner: hackathon_command_centre
--

CREATE TABLE public."AppControl" (
    id text NOT NULL,
    "controlType" public."AppControlType" NOT NULL,
    details jsonb NOT NULL,
    "isActive" boolean DEFAULT false NOT NULL
);


ALTER TABLE public."AppControl" OWNER TO hackathon_command_centre;

--
-- Name: Entry; Type: TABLE; Schema: public; Owner: hackathon_command_centre
--

CREATE TABLE public."Entry" (
    id text NOT NULL,
    title character varying NOT NULL,
    description character varying NOT NULL,
    members text NOT NULL,
    "imageUrl" text DEFAULT ''::text NOT NULL
);


ALTER TABLE public."Entry" OWNER TO hackathon_command_centre;

--
-- Name: Prize; Type: TABLE; Schema: public; Owner: hackathon_command_centre
--

CREATE TABLE public."Prize" (
    id text NOT NULL,
    name text NOT NULL,
    "votingType" public."VotingType" NOT NULL,
    description text DEFAULT ''::text NOT NULL,
    "autoRelease" boolean DEFAULT true NOT NULL,
    color text DEFAULT '#ffd800'::text NOT NULL,
    "imageUrl" text DEFAULT ''::text NOT NULL
);


ALTER TABLE public."Prize" OWNER TO hackathon_command_centre;

--
-- Name: User; Type: TABLE; Schema: public; Owner: hackathon_command_centre
--

CREATE TABLE public."User" (
    id text NOT NULL,
    "dateCreated" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP,
    "dateModified" timestamp(3) without time zone,
    email text NOT NULL
);


ALTER TABLE public."User" OWNER TO hackathon_command_centre;

--
-- Name: UserEntries; Type: TABLE; Schema: public; Owner: hackathon_command_centre
--

CREATE TABLE public."UserEntries" (
    id text NOT NULL,
    "user" text NOT NULL,
    entry text NOT NULL
);


ALTER TABLE public."UserEntries" OWNER TO hackathon_command_centre;

--
-- Name: Vote; Type: TABLE; Schema: public; Owner: hackathon_command_centre
--

CREATE TABLE public."Vote" (
    id text NOT NULL,
    "user" text NOT NULL,
    "numVotes" integer DEFAULT 0 NOT NULL,
    entry text NOT NULL,
    "isReleased" boolean DEFAULT false NOT NULL,
    prize text NOT NULL,
    "dateCreated" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public."Vote" OWNER TO hackathon_command_centre;

--
-- Name: _prisma_migrations; Type: TABLE; Schema: public; Owner: hackathon_command_centre
--

CREATE TABLE public._prisma_migrations (
    id character varying(36) NOT NULL,
    checksum character varying(64) NOT NULL,
    finished_at timestamp with time zone,
    migration_name character varying(255) NOT NULL,
    logs text,
    rolled_back_at timestamp with time zone,
    started_at timestamp with time zone DEFAULT now() NOT NULL,
    applied_steps_count integer DEFAULT 0 NOT NULL
);


ALTER TABLE public._prisma_migrations OWNER TO hackathon_command_centre;

--
-- Data for Name: AdminUser; Type: TABLE DATA; Schema: public; Owner: hackathon_command_centre
--

COPY public."AdminUser" ("user") FROM stdin;
clp8npp76000fpo8h8i8cf5sz
clp8pe6na0005po8h4fyc9nz6
clp8spbr10003po8hhi15pg8r
clp9uz68h0000po8hmkkn4boa
clp9wrmj50000va8ps68gqtoc
clp8t043k0004po8hwv0zmkbb
\.


--
-- Data for Name: AppControl; Type: TABLE DATA; Schema: public; Owner: hackathon_command_centre
--

COPY public."AppControl" (id, "controlType", details, "isActive") FROM stdin;
\.


--
-- Data for Name: Entry; Type: TABLE DATA; Schema: public; Owner: hackathon_command_centre
--

COPY public."Entry" (id, title, description, members, "imageUrl") FROM stdin;
clp8ng6zm0006po8hcbqwqbjm	Data engineering assistant	Let Google (or equivalent) be my assistant. Think Autopilot in Tesla, the driver is still in-charge and responsible, but Autopilot will help. This hack will explore:\n1. Research what other organizations are doing in this field, and suggest how to adopt the practices in DEng\n2. Building processes around how to best use Generative AI in DEng, and what to avoid\n3. Implementing AI tools/framework to resolve the problem statements	Daniel Ko, Lenno Yu	
clp8nhmzq0008po8hzjs7sb5u	Internal GPT	Knowing who to contact when we have a very specific question can be complicated, which is why having an internal assistant trained through documentation in Notion, which is difficult to navigate for new entrants, and in general through human feedback for having an “interactive” repository with the knowledge from the developers.	Martha Rodriguez, Obinna Onyema, Victor Garcia, Stefan Tasic	
clp8nik4o0009po8hsd476r6l	Gunicorn Stats	Let’s instrument gunicorn and see if we’re saturating our services during promos	Artur, Marina	
clp8nj655000apo8hwwssxkqr	Green Energy Rewards Program for IoT	Proof concept: Build out a secure network of the energy monitoring IoT devices in my smart home, and connect it to a new branded or other type of loyalty program.  Then create demo projects of various use cases for earning, redeeming and/or exchanging points with this system.  Caveats: All development will utilize secure test environments.  UIs may not be developed in time for demo day (ui devs could help with that!)	David Madi, Rei Nizami, Mark Cafazzo	
clp8njq3w000bpo8hzara7tmw	Jira GPT	Create a slack bot that makes jira tickets	Mychaylo, Irvin, Abraham	
clp8nklkx000cpo8h7k4km2ou	Interactive Kubernetes Learning	• Assist with preparing Devs with learning how Kubernetes works, without requiring a complex setup, in an interactive workshop environment.\n• Will leverage Jetbrains Academy courses + minikube to create a skeleton course and sample lesson.\n• Look for student testers, content creators	Dorian Pula, Christine Le, Tahreem, Sagar, Artur	
clp8nldjl000dpo8hh9hks0t2	Mentoring Manatees	A self-serve thing to match up Mentors and Mentees, with an outline of the different tracks (leadership, technical, etc) and a programme laid out to assist the mentors.	Jamie, Michael, Jake, Zohreh, Parisa	
clp8nlysu000epo8hfkh22xyr	Subscribe till flights	Subscription product has the fixed period (1 year) to finish subscription for all partners at this moment.\nThis hack will support short period subscriptions when a member wants to subscribe months until their flights.	Yun, Yaz, Kiki, Jorge	
clp8mq9mz0004po8h2r00xlaj	SFR Preview Tool	To use an AI or other automation tool to support template generation for chargeback disputes. \nWe have automated some parts of the process using Python. 	Thannia, Ken, Christina Spencer	
clp8nfqlb0005po8hvrohu5g7	Automate Chargebacks	To use an AI or other automation tool to support template generation for chargeback disputes. \nWe have automated some parts of the process using Python.	Merisha Martin, Taniya Arora, Lavina Pathak, Kevin Howe, Muhamman Khalid	
clp9v9po8000epo8he4i5uhsi	something-something-data	We’re not making the most of the the data we have 	Ofer, Leonid, Bar, Sagar, Taniya	
clp9va0lv000fpo8h38afr57s	External endpoint performance tuning	Automatic traffic throttling based on endpoint latency	Eric	
clp9vaoeu000gpo8hc77dho1n	LCP Test Fixtures Part II	Flesh out matrix/lcp-test-fixtures use cases, with focus on plugging it to existing test suites to gauge performance & dev time improvements on flows that are already setup	Felipe, Arco, Liam	
clp9v7rz7000cpo8hj4wekd3i	PlusGrade for Retail	Exploring the LCR Model in other industries (Retail and Gaming)	Vikas, James, Yostina	
clp9v8lpf000dpo8hcroabax9	The Tragically Git	Improving the offer select component in storefront in order to increase average transaction size	Tony	
clp8ngr850007po8h7tw98ftt	Earn Streaks	Offer increasing earn bonuses which reset if the user stops transacting consistently	Curtis, Taz, Yashaayan, Ben	
\.


--
-- Data for Name: Prize; Type: TABLE DATA; Schema: public; Owner: hackathon_command_centre
--

COPY public."Prize" (id, name, "votingType", description, "autoRelease", color, "imageUrl") FROM stdin;
clp8movr40003po8hk44ct7ez	Best Presentation	SINGLE_VOTE	Show and wow the tech pitch-perfect performance - tech talk magic!	f	#2f2cf2	https://hackathon-command-centre.fly.dev/images/hackathon-award.png
clp8mkal10002po8huax3svf1	Best Hack	DISTRIBUTE_VOTES	ETERNAL GLORY	f	#ffd700	https://hackathon-command-centre.fly.dev/images/eternal-glory-man-v2.png
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: hackathon_command_centre
--

COPY public."User" (id, "dateCreated", "dateModified", email) FROM stdin;
clp8npp76000fpo8h8i8cf5sz	2023-11-21 18:16:04.05	2023-11-21 18:16:04.05	tina.siu@points.com
clp8pe6na0005po8h4fyc9nz6	2023-11-21 19:03:06.023	2023-11-21 19:03:06.023	thaimar.barco@points.com
clp8spbr10003po8hhi15pg8r	2023-11-21 20:35:44.701	2023-11-21 20:35:44.701	jeff.byrne@points.com
clp8t043k0004po8hwv0zmkbb	2023-11-21 20:44:08	2023-11-21 20:44:08	jane.helman@points.com
clp9uz68h0000po8hmkkn4boa	2023-11-22 14:27:09.522	2023-11-22 14:27:09.522	ofer.guttman@points.com
clp9wrmj50000va8ps68gqtoc	2023-11-22 15:17:16.626	2023-11-22 15:17:16.626	jamie.weatherby@ploints.com
clp9zauly0000po8qaarsnpe2	2023-11-22 16:28:12.791	2023-11-22 16:28:12.791	jamie.weatherby@points.com
clp9zk9rw0000va8pwn8jugab	2023-11-22 16:35:32.349	2023-11-22 16:35:32.349	christine.le@points.com
clpa00nt90002va8pa1iotpq6	2023-11-22 16:48:17.037	2023-11-22 16:48:17.037	reiyyan.nizami@points.com
clpa00okz000cpu8qg0bxickx	2023-11-22 16:48:18.036	2023-11-22 16:48:18.036	jake.defranco@points.com
clpa00s7j000ion8qiw0j1iib	2023-11-22 16:48:22.735	2023-11-22 16:48:22.735	matthew.tatarsky@points.com
clpa00to50000r18p7w0y4n4f	2023-11-22 16:48:24.629	2023-11-22 16:48:24.629	
clpa00tzw0004va8p04skxojt	2023-11-22 16:48:25.052	2023-11-22 16:48:25.052	jorge.watty@points.com
clpa00u3v000jon8qjduztbi4	2023-11-22 16:48:25.196	2023-11-22 16:48:25.196	yasmary.mora@points.com
clpa00v8p000epu8qxclndnvy	2023-11-22 16:48:26.665	2023-11-22 16:48:26.665	josh.marston@points.com
clpa00xqc0002r18potea6462	2023-11-22 16:48:29.892	2023-11-22 16:48:29.892	daniel.ko@points.com
clpa0136l000fpu8qjbq4jgph	2023-11-22 16:48:36.957	2023-11-22 16:48:36.957	anthony.tomarchio@points.com
clpa0182g0006va8pmn1aapf2	2023-11-22 16:48:43.288	2023-11-22 16:48:43.288	deanna.carr@points.com
clpa018sk000hpu8q9wbjc2jf	2023-11-22 16:48:44.228	2023-11-22 16:48:44.228	liam.chen@Points.com
clpa01e40000lon8qhxnthv1h	2023-11-22 16:48:51.12	2023-11-22 16:48:51.12	brian.geng@points.com
clpa01h250007va8pxio7jrvp	2023-11-22 16:48:54.941	2023-11-22 16:48:54.941	david.madi@points.com
clpa01iwc0000q08rpvd18kgw	2023-11-22 16:48:57.324	2023-11-22 16:48:57.324	marina.leikin@points.com
clpa01jtl0004r18pz4igongi	2023-11-22 16:48:58.521	2023-11-22 16:48:58.521	leonid.gilburd@points.com
clpa01lxb0009va8pt21eejzu	2023-11-22 16:49:01.248	2023-11-22 16:49:01.248	lenno.yu@points.com
clpa01mwv0002q08rxtgei6sy	2023-11-22 16:49:02.528	2023-11-22 16:49:02.528	dylan.cherry@plusgrade.com
clpa01nri0006r18pfqadsrpv	2023-11-22 16:49:03.63	2023-11-22 16:49:03.63	alan+privacy@points.com
clpa01o0j0007r18pip0c316p	2023-11-22 16:49:03.955	2023-11-22 16:49:03.955	conor.geaney@points.com
clpa01ygj000jpu8qcxdxprj4	2023-11-22 16:49:17.492	2023-11-22 16:49:17.492	thannia.blanchet@points.com
clpa01zqv000mon8q9nbcqysb	2023-11-22 16:49:19.159	2023-11-22 16:49:19.159	kiki.chan@points.com
clpa020ox000oon8q5sr2fxpm	2023-11-22 16:49:20.385	2023-11-22 16:49:20.385	leanna.oneill@points.com
clpa0224q0000po8qafaa0r8p	2023-11-22 16:49:22.251	2023-11-22 16:49:22.251	suvidha.saluja@points.com
clpa02390000cq08rurrbh3oo	2023-11-22 16:49:23.7	2023-11-22 16:49:23.7	alvin.varghese@points.com
clpa029n4000lpu8qyf8qpm4g	2023-11-22 16:49:31.985	2023-11-22 16:49:31.985	tasneem.hoda@points.com
clpa02d83000npu8qn5j6y94f	2023-11-22 16:49:36.628	2023-11-22 16:49:36.628	siddharth.panjwani@points.com
clpa02de6000eq08rnw7q1tz4	2023-11-22 16:49:36.846	2023-11-22 16:49:36.846	laura.wong@points.com
clpa02l4p000bva8pgsopl9nh	2023-11-22 16:49:46.874	2023-11-22 16:49:46.874	lori.livadariu@points.com
clpa02qd90001po8qjnv48q89	2023-11-22 16:49:53.662	2023-11-22 16:49:53.662	carla.barry@points.com
clpa02ro2000fq08rd0zbt2ed	2023-11-22 16:49:55.346	2023-11-22 16:49:55.346	zoraiz.khurshied@points.com
clpa02w1l000uon8qc1c6jqv9	2023-11-22 16:50:01.017	2023-11-22 16:50:01.017	mark.cafazzo@points.com
clpa0301q000won8q30lomd3h	2023-11-22 16:50:06.207	2023-11-22 16:50:06.207	christina.spencer@points.com
clpa035zv000tpu8q4mqdtjf4	2023-11-22 16:50:13.915	2023-11-22 16:50:13.915	kristina.iermolenko@points.com
clpa03aqq000gq08ruo68zmmt	2023-11-22 16:50:20.066	2023-11-22 16:50:20.066	curtis.jones@points.com
clpa03eyq000dr18p62t9j1aj	2023-11-22 16:50:25.538	2023-11-22 16:50:25.538	michael.nichols@points.com
clpa03rg7000upu8qdh8dpyo1	2023-11-22 16:50:41.72	2023-11-22 16:50:41.72	artur.levchenko@points.com
clpa03yui0014on8qer2lnf41	2023-11-22 16:50:51.306	2023-11-22 16:50:51.306	veronica.merino@points.com
clpa044ja000xpu8q3gwmltvy	2023-11-22 16:50:58.678	2023-11-22 16:50:58.678	victor.garcia@points.com
clpa04c0q000gva8pxn4r985e	2023-11-22 16:51:08.379	2023-11-22 16:51:08.379	danielle.brown@plusgrade.com
clpa04k7g000qq08rbzle7mly	2023-11-22 16:51:18.989	2023-11-22 16:51:18.989	abraham.hurtado@points.com
clpa05mvm001apu8qw98jfov8	2023-11-22 16:52:09.107	2023-11-22 16:52:09.107	stephanie.naranjo@points.com
clpa05xas001bpu8qxgljvnf5	2023-11-22 16:52:22.612	2023-11-22 16:52:22.612	mychaylo.gerus@points.com
clpa060s00011r18pobzdcmc6	2023-11-22 16:52:27.12	2023-11-22 16:52:27.12	lily.dittschlag@points.com
clpa062wi000nva8pfdrxhlb6	2023-11-22 16:52:29.875	2023-11-22 16:52:29.875	chris.ovsenny@points.com
clpa067b80019on8qt7xy3lfg	2023-11-22 16:52:35.589	2023-11-22 16:52:35.589	raghu.chintaala@points.com
clpa06k0c001kpu8qc7mid9cs	2023-11-22 16:52:52.044	2023-11-22 16:52:52.044	obinna.onyema@points.com
clpa06lum0010q08r5k0lubd4	2023-11-22 16:52:54.43	2023-11-22 16:52:54.43	daniel.jung@points.com
clpa07bgk0012q08r4hz0xrxm	2023-11-22 16:53:27.621	2023-11-22 16:53:27.621	rohan.dcosta@points.com
clpa07dtr001qpu8qzf6gyw3o	2023-11-22 16:53:30.688	2023-11-22 16:53:30.688	jamie.anderson@points.com
clpa08fz40013q08rxe1oo02u	2023-11-22 16:54:20.129	2023-11-22 16:54:20.129	catherine.mariani@points.com
clpa08ntf000gpo8q0qnm6cf3	2023-11-22 16:54:30.292	2023-11-22 16:54:30.292	stefan.tasic@points.com
clpa08zq9001ion8qb39zwl64	2023-11-22 16:54:45.729	2023-11-22 16:54:45.729	ken.rettberg@points.com
clpa091ot001kon8q3ia0d6ot	2023-11-22 16:54:48.269	2023-11-22 16:54:48.269	mounika.rasukachula@points.com
clpa09pmc001wpu8qafj29y0g	2023-11-22 16:55:19.285	2023-11-22 16:55:19.285	martha.rodriguez@points.com
clpa0a0cw000npo8qiu1on24h	2023-11-22 16:55:33.2	2023-11-22 16:55:33.2	julia.gumerova@points.com
clpa0a0mb0014q08rfhmqj042	2023-11-22 16:55:33.54	2023-11-22 16:55:33.54	henry.valbuena@points.com
clpa0a6mh0016q08rbcerl6hi	2023-11-22 16:55:41.322	2023-11-22 16:55:41.322	raghav.kandubai@points.com
clpa0a7rg000opo8q8gt0e1h0	2023-11-22 16:55:42.797	2023-11-22 16:55:42.797	yashaayan.yogeswaran@points.com
clpa0arjl0017q08rq00cgxii	2023-11-22 16:56:08.433	2023-11-22 16:56:08.433	amruta.gurav@points.com
clpa0azxb001nr18pr2niqbgd	2023-11-22 16:56:19.295	2023-11-22 16:56:19.295	dana.filatov@points.com
clpa0c0ap0015po8qy56ztfi3	2023-11-22 16:57:06.434	2023-11-22 16:57:06.434	olufemi.ayodele@points.com
clpa0c2z4001pr18pkaftww7i	2023-11-22 16:57:09.904	2023-11-22 16:57:09.904	1@1.1
clpa0c84h0016po8qg102t7zm	2023-11-22 16:57:16.577	2023-11-22 16:57:16.577	basil.earle@points.com
clpa0db480020va8pssnhknlj	2023-11-22 16:58:07.112	2023-11-22 16:58:07.112	parisa.khazaei@points.com
clpa0du8o001mq08raus3uucs	2023-11-22 16:58:31.896	2023-11-22 16:58:31.896	atishay.goyal@points.com
clpa0l7jl0022q08rrreztqoe	2023-11-22 17:04:15.729	2023-11-22 17:04:15.729	james.williams@points.com
clpa0p0ds0025q08r62i7l70z	2023-11-22 17:07:13.072	2023-11-22 17:07:13.072	kyle.nhu@points.com
clpa0ekez0022va8pmq3kaigy	2023-11-22 16:59:05.819	2023-11-22 16:59:05.819	zohreh.zadeh@points.com
clpa0nh95002mva8pngzxzeag	2023-11-22 17:06:01.625	2023-11-22 17:06:01.625	merisha.martin@points.com
clpa0f2580034pu8qpceu7m3g	2023-11-22 16:59:28.797	2023-11-22 16:59:28.797	irvin.gomes@points.com
clpa0g196001nq08r2uca7f63	2023-11-22 17:00:14.299	2023-11-22 17:00:14.299	ben.mcinroy@points.com
clpa0glud001wq08rwid3fm6e	2023-11-22 17:00:40.982	2023-11-22 17:00:40.982	rashesh.ambani@points.com
clpa0gqmr002ava8pyx5n2vi1	2023-11-22 17:00:47.187	2023-11-22 17:00:47.187	donald.dew@points.com
clpa0mh5l002kva8pn5efaz8t	2023-11-22 17:05:14.841	2023-11-22 17:05:14.841	yun.namkung@points.com
clpa0tapw002mq08rlmutqh0g	2023-11-22 17:10:33.092	2023-11-22 17:10:33.092	raul.cruz@points.com
clpa0lo8a001von8qby4sz21b	2023-11-22 17:04:37.354	2023-11-22 17:04:37.354	mleikin@hotmail.com
clpa0xeub0023on8qhui1ja4f	2023-11-22 17:13:45.06	2023-11-22 17:13:45.06	lavina.pathak@points.com
clpa0npam0049pu8q7cucq53s	2023-11-22 17:06:12.046	2023-11-22 17:06:12.046	amber.kim@points.com
clpa0pwol0006po8qkekhb7yz	2023-11-22 17:07:54.934	2023-11-22 17:07:54.934	sagar.tomar@points.com
clpa0scbl0008po8qy37jmav4	2023-11-22 17:09:48.514	2023-11-22 17:09:48.514	ana.gamboa@points.com
clpa0s3se004hpu8q67a52qbu	2023-11-22 17:09:37.454	2023-11-22 17:09:37.454	tahreem.butt@points.com
clpa0w2f10026r18punynbagj	2023-11-22 17:12:42.302	2023-11-22 17:12:42.302	gavin.dmello@points.com
clpa0z8y80028r18p8ce34l69	2023-11-22 17:15:10.736	2023-11-22 17:15:10.736	danafeldman97@gmail.com
clpa118o7002yq08rvqp1ukij	2023-11-22 17:16:43.688	2023-11-22 17:16:43.688	karen.kua@points.com
clpa134cl0025on8qxxd51wfb	2023-11-22 17:18:11.397	2023-11-22 17:18:11.397	delivery.integrations@points.com
clpa165ne002br18pac1d3bzj	2023-11-22 17:20:33.05	2023-11-22 17:20:33.05	cezar.lutac@points.com
clpa17k830027on8qzaet9vq3	2023-11-22 17:21:38.595	2023-11-22 17:21:38.595	lily.szeto@points.com
clpa1992w002ir18pggihja2o	2023-11-22 17:22:57.464	2023-11-22 17:22:57.464	sabesan.shanmu@points.com
clpa1ah9b002wva8pi7h5zm2j	2023-11-22 17:23:54.72	2023-11-22 17:23:54.72	gabriel.morais@points.com
clpa1b7bg002con8qjw66kfay	2023-11-22 17:24:28.493	2023-11-22 17:24:28.493	irvin.r.gomes@gmail.com
clpa1bg330031q08rodho385b	2023-11-22 17:24:39.856	2023-11-22 17:24:39.856	felipe.suman@points.com
clpa1doph004rpu8qc80rksir	2023-11-22 17:26:24.341	2023-11-22 17:26:24.341	james.birch@plusgrade.com
clpa1f3c0002yva8p9vwh0n0b	2023-11-22 17:27:29.953	2023-11-22 17:27:29.953	jerome.chin@points.com
clpa1fpkj0008po8qhwtl6w7o	2023-11-22 17:27:58.771	2023-11-22 17:27:58.771	mark.armanious@points.com
clpa1i7f1002jon8qf29xnxdc	2023-11-22 17:29:55.214	2023-11-22 17:29:55.214	muhammad.khalid@points.com
clpa1jj62003aq08rn18cee9j	2023-11-22 17:30:57.098	2023-11-22 17:30:57.098	tina.burgess@points.com
clpa1mkpb004tpu8qhgdexz61	2023-11-22 17:33:19.056	2023-11-22 17:33:19.056	vikas.padiyar@points.com
clpa1mv29003bva8pq3i4l7vs	2023-11-22 17:33:32.481	2023-11-22 17:33:32.481	taniya.arora@points.com
clpa1q6n6002jr18pm5p6g9aw	2023-11-22 17:36:07.458	2023-11-22 17:36:07.458	vitor.aranha@points.com
clpa1qio2002lr18pc67azxq0	2023-11-22 17:36:23.042	2023-11-22 17:36:23.042	claudia.kielb@plusgrade.com
clpa1rnx9004upu8qpt54b4wg	2023-11-22 17:37:16.51	2023-11-22 17:37:16.51	veronica.perez@points.com
clpa1txsa003iva8p03v79bh5	2023-11-22 17:39:02.603	2023-11-22 17:39:02.603	claudia.kielb@points.com
clpa1vk6q002won8q60cjpj78	2023-11-22 17:40:18.291	2023-11-22 17:40:18.291	sue.work@points.com
clpa221ad005bpu8q2dsqbndr	2023-11-22 17:45:20.39	2023-11-22 17:45:20.39	arco@points.com
clpa22b3e0000po8q0v8hkwcs	2023-11-22 17:45:33.098	2023-11-22 17:45:33.098	martymcfly@gmail.com
clpa246wv0035on8qh089uf1x	2023-11-22 17:47:00.991	2023-11-22 17:47:00.991	jeffrey.jewitt@points.com
clpa24fbj003kva8plugh42i5	2023-11-22 17:47:11.888	2023-11-22 17:47:11.888	ryan.mody@points.com
clpa26rg8005dpu8qrnjtd6qm	2023-11-22 17:49:00.921	2023-11-22 17:49:00.921	rahimmody488@gmail.com
clpa27vdn003mva8px7hevy3h	2023-11-22 17:49:52.668	2023-11-22 17:49:52.668	jeffrey.jewitt+real@points.com
clpa28ni20000po8px4ssrg8i	2023-11-22 17:50:29.114	2023-11-22 17:50:29.114	michael.wang@points.com
clpa2ccy8003yva8pou67cav1	2023-11-22 17:53:22.065	2023-11-22 17:53:22.065	justin.stewart@points.com
clpa2e549008qpu8qxz6pkw6h	2023-11-22 17:54:45.225	2023-11-22 17:54:45.225	sarim.daud@points.com
clpa2fjyz0068q08rzsi1dasm	2023-11-22 17:55:51.132	2023-11-22 17:55:51.132	madhav.ramdin@points.com
clpa2hpik005pva8pbm4xytu8	2023-11-22 17:57:31.629	2023-11-22 17:57:31.629	jean-kristof.dufresne@plusgrade.com
clpa2knir0069q08r42rstb2r	2023-11-22 17:59:49.011	2023-11-22 17:59:49.011	theodore.choutzoumis@points.com
clpa2oaxk009fpu8qpjeb9w7b	2023-11-22 18:02:39.32	2023-11-22 18:02:39.32	garima.chopra@points.com
clpa2qkhn006aq08redoa20sa	2023-11-22 18:04:25.019	2023-11-22 18:04:25.019	sneha.savarimuthu@points.com
clpa41x9w0000pu8qfwzjah8z	2023-11-22 18:41:14.42	2023-11-22 18:41:14.42	jeanmarc.chartier@points.com
clpvmw87f0000r18h22qkelaj	2023-12-07 20:11:51.051	2023-12-07 20:11:51.051	jamie.weatherby.points@points.com
\.


--
-- Data for Name: UserEntries; Type: TABLE DATA; Schema: public; Owner: hackathon_command_centre
--

COPY public."UserEntries" (id, "user", entry) FROM stdin;
clp8npp7c000gpo8hzp48b48x	clp8npp76000fpo8h8i8cf5sz	clp8nfqlb0005po8hvrohu5g7
clp8pe6ng0006po8hcau92um6	clp8pe6na0005po8h4fyc9nz6	clp8nik4o0009po8hsd476r6l
clp9wrmjf0001va8pg5m2r3k3	clp9wrmj50000va8ps68gqtoc	clp8nldjl000dpo8hh9hks0t2
clp9zaum40001po8q3soox9ma	clp9zauly0000po8qaarsnpe2	clp8nldjl000dpo8hh9hks0t2
clp9zk9s30001va8pltu9hy0w	clp9zk9rw0000va8pwn8jugab	clp8nklkx000cpo8h7k4km2ou
clpa00ntc0003va8pd8vbfgaq	clpa00nt90002va8pa1iotpq6	clp8nj655000apo8hwwssxkqr
clpa00ol4000dpu8qxkq7k1p7	clpa00okz000cpu8qg0bxickx	clp8nldjl000dpo8hh9hks0t2
clpa00toa0001r18p00ws6r5u	clpa00to50000r18p7w0y4n4f	clp8nldjl000dpo8hh9hks0t2
clpa00u010005va8pae6rjwrr	clpa00tzw0004va8p04skxojt	clp8nlysu000epo8hfkh22xyr
clpa00u3y000kon8qvzy43eni	clpa00u3v000jon8qjduztbi4	clp8nlysu000epo8hfkh22xyr
clpa00xqf0003r18pbiv3w7fj	clpa00xqc0002r18potea6462	clp8ng6zm0006po8hcbqwqbjm
clpa0136o000gpu8q8oaxmqh6	clpa0136l000fpu8qjbq4jgph	clp9v8lpf000dpo8hcroabax9
clpa018so000ipu8qg1u12hac	clpa018sk000hpu8q9wbjc2jf	clp9vaoeu000gpo8hc77dho1n
clpa01h2g0008va8pin5b25rb	clpa01h250007va8pxio7jrvp	clp8nj655000apo8hwwssxkqr
clpa01jtq0005r18pv2uttsco	clpa01jtl0004r18pz4igongi	clp9v9po8000epo8he4i5uhsi
clpa01lxg000ava8pstrvdrt1	clpa01lxb0009va8pt21eejzu	clp8ng6zm0006po8hcbqwqbjm
clpa01ygn000kpu8q2ofdnyd3	clpa01ygj000jpu8qcxdxprj4	clp8mq9mz0004po8h2r00xlaj
clpa01zqy000non8qkfo63lxq	clpa01zqv000mon8q9nbcqysb	clp8nlysu000epo8hfkh22xyr
clpa029n8000mpu8qmg4j55ln	clpa029n4000lpu8qyf8qpm4g	clp8ngr850007po8h7tw98ftt
clpa02d86000opu8qds2y3ojh	clpa02d83000npu8qn5j6y94f	clp8mq9mz0004po8h2r00xlaj
clpa02qdf0002po8q115e896z	clpa02qd90001po8qjnv48q89	clp8nfqlb0005po8hvrohu5g7
clpa02w1p000von8qri17nf19	clpa02w1l000uon8qc1c6jqv9	clp8nj655000apo8hwwssxkqr
clpa0301u000xon8qb04bso9s	clpa0301q000won8q30lomd3h	clp9v7rz7000cpo8hj4wekd3i
clpa03aqu000hq08rit3em1ea	clpa03aqq000gq08ruo68zmmt	clp8ngr850007po8h7tw98ftt
clpa03rgc000vpu8q5gfi56eu	clpa03rg7000upu8qdh8dpyo1	clp8nik4o0009po8hsd476r6l
clpa03rgc000wpu8qyygfio5s	clpa03rg7000upu8qdh8dpyo1	clp8nklkx000cpo8h7k4km2ou
clpa044je000ypu8qfazum4aw	clpa044ja000xpu8q3gwmltvy	clp8nhmzq0008po8hzjs7sb5u
clpa04k7k000rq08rs540zh4s	clpa04k7g000qq08rbzle7mly	clp8njq3w000bpo8hzara7tmw
clpa05xav001cpu8qnh0ye8uw	clpa05xas001bpu8qxgljvnf5	clp8njq3w000bpo8hzara7tmw
clpa060s40012r18pz98qkpvn	clpa060s00011r18pobzdcmc6	clp8nlysu000epo8hfkh22xyr
clpa06k0f001lpu8qaz4seqm4	clpa06k0c001kpu8qc7mid9cs	clp8nhmzq0008po8hzjs7sb5u
clpa06lur0011q08r8rkx5zoh	clpa06lum0010q08r5k0lubd4	clp8nlysu000epo8hfkh22xyr
clpa08ntk000hpo8q9aogbd5g	clpa08ntf000gpo8q0qnm6cf3	clp8nhmzq0008po8hzjs7sb5u
clpa08zqd001jon8qjs7xcigv	clpa08zq9001ion8qb39zwl64	clp8mq9mz0004po8h2r00xlaj
clpa091ow001lon8qeuyci7xf	clpa091ot001kon8q3ia0d6ot	clp8nlysu000epo8hfkh22xyr
clpa09pmg001xpu8q4p7cb984	clpa09pmc001wpu8qafj29y0g	clp8nhmzq0008po8hzjs7sb5u
clpa0a0mg0015q08r504o3fbw	clpa0a0mb0014q08rfhmqj042	clp8mq9mz0004po8h2r00xlaj
clpa0a7rk000ppo8qufhm28s4	clpa0a7rg000opo8q8gt0e1h0	clp8ngr850007po8h7tw98ftt
clpa0arjr0018q08r9iwc1udc	clpa0arjl0017q08rq00cgxii	clp8ng6zm0006po8hcbqwqbjm
clpa0azxe001or18pxx0dudej	clpa0azxb001nr18pr2niqbgd	clp8ngr850007po8h7tw98ftt
clpa0c2z8001qr18put6888fg	clpa0c2z4001pr18pkaftww7i	clp8njq3w000bpo8hzara7tmw
clpa0db4c0021va8pcsb69s4y	clpa0db480020va8pssnhknlj	clp8nldjl000dpo8hh9hks0t2
clpa0ekf50023va8peercwenk	clpa0ekez0022va8pmq3kaigy	clp8nlysu000epo8hfkh22xyr
clpa0g19a001oq08rn57v19o2	clpa0g196001nq08r2uca7f63	clp8ngr850007po8h7tw98ftt
clpa0gluh001xq08r5ny11ljr	clpa0glud001wq08rwid3fm6e	clp8ngr850007po8h7tw98ftt
clpa0mh5p002lva8pjg8xcyw8	clpa0mh5l002kva8pn5efaz8t	clp8nlysu000epo8hfkh22xyr
clpa0nh98002nva8phicyt3t2	clpa0nh95002mva8pngzxzeag	clp8nfqlb0005po8hvrohu5g7
clpa0npar004apu8qo3o9tqfu	clpa0npam0049pu8q7cucq53s	clp8nlysu000epo8hfkh22xyr
clpa0pwoq0007po8qwuk3r80d	clpa0pwol0006po8qkekhb7yz	clp9v9po8000epo8he4i5uhsi
clpa0s3sh004ipu8qzgpotytt	clpa0s3se004hpu8q67a52qbu	clp8nklkx000cpo8h7k4km2ou
clpa0tapz002nq08rv3yqm3v6	clpa0tapw002mq08rlmutqh0g	clp8mq9mz0004po8h2r00xlaj
clpa0w2f60027r18pjga28xwg	clpa0w2f10026r18punynbagj	clp8nik4o0009po8hsd476r6l
clpa0xeue0024on8qeltz8qbe	clpa0xeub0023on8qhui1ja4f	clp8nldjl000dpo8hh9hks0t2
clpa134co0026on8qn0vmbh3z	clpa134cl0025on8qxxd51wfb	clp8nlysu000epo8hfkh22xyr
clpa1ah9g002xva8pxyih9dwi	clpa1ah9b002wva8pi7h5zm2j	clp8nhmzq0008po8hzjs7sb5u
clpa1b7bm002don8qtd2v9cvi	clpa1b7bg002con8qjw66kfay	clp8njq3w000bpo8hzara7tmw
clpa1bg370032q08ryn6tb4nk	clpa1bg330031q08rodho385b	clp9vaoeu000gpo8hc77dho1n
clpa1dopm004spu8q8zccw3cu	clpa1doph004rpu8qc80rksir	clp8nhmzq0008po8hzjs7sb5u
clpa1fpko0009po8qkrm4tcla	clpa1fpkj0008po8qhwtl6w7o	clp8mq9mz0004po8h2r00xlaj
clpa1i7f5002kon8qyccd2fm0	clpa1i7f1002jon8qf29xnxdc	clp8nfqlb0005po8hvrohu5g7
clpa1mv2c003cva8p9mswgort	clpa1mv29003bva8pq3i4l7vs	clp8njq3w000bpo8hzara7tmw
clpa1q6n9002kr18pjrrumrp3	clpa1q6n6002jr18pm5p6g9aw	clp8nhmzq0008po8hzjs7sb5u
clpa1qio6002mr18pq8xzli95	clpa1qio2002lr18pc67azxq0	clp8nhmzq0008po8hzjs7sb5u
clpa1rnxe004vpu8q4v3seqy5	clpa1rnx9004upu8qpt54b4wg	clp8nklkx000cpo8h7k4km2ou
clpa1txse003jva8ptztbdzi7	clpa1txsa003iva8p03v79bh5	clp8ng6zm0006po8hcbqwqbjm
clpa221ah005cpu8qabpnmc9t	clpa221ad005bpu8q2dsqbndr	clp9vaoeu000gpo8hc77dho1n
clpa22b3j0001po8qzt7i4v18	clpa22b3e0000po8q0v8hkwcs	clp8ng6zm0006po8hcbqwqbjm
clpa246wy0036on8qxhactpra	clpa246wv0035on8qh089uf1x	clp8nklkx000cpo8h7k4km2ou
clpa24fbn003lva8pfvymi3no	clpa24fbj003kva8plugh42i5	clp9v7rz7000cpo8hj4wekd3i
clpa28ni60001po8pb5xtzzd0	clpa28ni20000po8px4ssrg8i	clp8nldjl000dpo8hh9hks0t2
clpa2hpio005qva8pbw3g1kvb	clpa2hpik005pva8pbm4xytu8	clp8ngr850007po8h7tw98ftt
clpa2oaxn009gpu8qu8zfoefa	clpa2oaxk009fpu8qpjeb9w7b	clp8nfqlb0005po8hvrohu5g7
clpa2qkht006bq08rt03pmcxx	clpa2qkhn006aq08redoa20sa	clp8nhmzq0008po8hzjs7sb5u
clpa41xa20001pu8qbn2z4c3k	clpa41x9w0000pu8qfwzjah8z	clp8nklkx000cpo8h7k4km2ou
clpvmxwrk0001r18h1zy6d9xx	clpvmw87f0000r18h22qkelaj	clp8nldjl000dpo8hh9hks0t2
\.


--
-- Data for Name: Vote; Type: TABLE DATA; Schema: public; Owner: hackathon_command_centre
--

COPY public."Vote" (id, "user", "numVotes", entry, "isReleased", prize, "dateCreated") FROM stdin;
clpa2e3j00055va8ps1bvzk1p	clpa2ccy8003yva8pou67cav1	1	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 17:54:43.164
clp9zrdey0007pu8q7g3eyj21	clp9zk9rw0000va8pwn8jugab	2	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 16:41:03.658
clp9zrdey0008pu8quchr5iaz	clp9zk9rw0000va8pwn8jugab	4	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 16:41:03.658
clp9zrdey0009pu8qfe18hiqz	clp9zk9rw0000va8pwn8jugab	3	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:41:03.658
clp9zrdey000apu8q1ggzsvxl	clp9zk9rw0000va8pwn8jugab	1	clp9va0lv000fpo8h38afr57s	t	clp8mkal10002po8huax3svf1	2023-11-22 16:41:03.658
clpa022n90007q08r3zcoskah	clpa018sk000hpu8q9wbjc2jf	1	clp8nklkx000cpo8h7k4km2ou	t	clp8mkal10002po8huax3svf1	2023-11-22 16:49:22.917
clpa022n90008q08r508quq41	clpa018sk000hpu8q9wbjc2jf	2	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 16:49:22.917
clpa02mxt000pon8q3x6draw4	clpa00xqc0002r18potea6462	1	clp9v7rz7000cpo8hj4wekd3i	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:49:49.218
clp9zrdey000bpu8qwtxm4r7v	clp9zk9rw0000va8pwn8jugab	1	clp8ngr850007po8h7tw98ftt	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:41:03.659
clpa022n9000bq08ri5keokvt	clpa018sk000hpu8q9wbjc2jf	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:49:22.917
clpa02eig000cr18p418gkytu	clpa00v8p000epu8qxclndnvy	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:49:38.296
clpa02h6j000spu8qbl1untsf	clpa0182g0006va8pmn1aapf2	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:49:41.755
clpa022n90009q08r4nabchkm	clpa018sk000hpu8q9wbjc2jf	4	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 16:49:22.917
clpa022n9000aq08rphva1tfr	clpa018sk000hpu8q9wbjc2jf	3	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:49:22.917
clpa02eif0008r18p73hsinme	clpa00v8p000epu8qxclndnvy	3	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 16:49:38.296
clpa02eif0009r18pl2fwru39	clpa00v8p000epu8qxclndnvy	3	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:49:38.296
clpa02eif000ar18piphlq67z	clpa00v8p000epu8qxclndnvy	1	clp9vaoeu000gpo8hc77dho1n	t	clp8mkal10002po8huax3svf1	2023-11-22 16:49:38.296
clpa02eif000br18pv6ednfv7	clpa00v8p000epu8qxclndnvy	3	clp8nklkx000cpo8h7k4km2ou	t	clp8mkal10002po8huax3svf1	2023-11-22 16:49:38.296
clpa02h6h000ppu8q3ib5unz6	clpa0182g0006va8pmn1aapf2	4	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 16:49:41.754
clpa02h6h000qpu8qa08nzv51	clpa0182g0006va8pmn1aapf2	4	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:49:41.754
clpa02h6h000rpu8qogn96xar	clpa0182g0006va8pmn1aapf2	2	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 16:49:41.754
clpa02mxv000qon8qa8opf895	clpa00xqc0002r18potea6462	1	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 16:49:49.22
clpa02mxv000ron8qjwogyx6u	clpa00xqc0002r18potea6462	1	clp9vaoeu000gpo8hc77dho1n	t	clp8mkal10002po8huax3svf1	2023-11-22 16:49:49.22
clpa04aje000zpu8q083hppyz	clpa01h250007va8pxio7jrvp	4	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 16:51:06.459
clpa04aje0010pu8q2xgtnplc	clpa01h250007va8pxio7jrvp	2	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 16:51:06.459
clpa04aje0011pu8q9tiigh5f	clpa01h250007va8pxio7jrvp	2	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:51:06.459
clpa04aje0012pu8qvlqaph5b	clpa01h250007va8pxio7jrvp	2	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 16:51:06.459
clpa04dz00016on8qpxpek16g	clpa03eyq000dr18p62t9j1aj	2	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:51:10.908
clpa04dz00017on8qyzjwej5k	clpa03eyq000dr18p62t9j1aj	4	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 16:51:10.908
clpa04dz00018on8qb12v25af	clpa03eyq000dr18p62t9j1aj	4	clp9v8lpf000dpo8hcroabax9	t	clp8mkal10002po8huax3svf1	2023-11-22 16:51:10.908
clpa1sjot002or18p9awkdlsi	clpa1mv29003bva8pq3i4l7vs	1	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 17:37:57.677
clpa1sjot002pr18p1aoa4kzu	clpa1mv29003bva8pq3i4l7vs	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8mkal10002po8huax3svf1	2023-11-22 17:37:57.677
clpa1sjot002qr18pte27qliz	clpa1mv29003bva8pq3i4l7vs	1	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 17:37:57.677
clpa1sjot002rr18p4rkdhrff	clpa1mv29003bva8pq3i4l7vs	1	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 17:37:57.677
clpa1sjot002sr18p656ysyeq	clpa1mv29003bva8pq3i4l7vs	1	clp8nhmzq0008po8hzjs7sb5u	t	clp8mkal10002po8huax3svf1	2023-11-22 17:37:57.677
clpa1sjot002tr18pru6g4bn2	clpa1mv29003bva8pq3i4l7vs	1	clp9v7rz7000cpo8hj4wekd3i	t	clp8mkal10002po8huax3svf1	2023-11-22 17:37:57.677
clpa1sjot002ur18ph10k7cp7	clpa1mv29003bva8pq3i4l7vs	1	clp9v9po8000epo8he4i5uhsi	t	clp8mkal10002po8huax3svf1	2023-11-22 17:37:57.677
clpa1sjot002vr18piufnei7f	clpa1mv29003bva8pq3i4l7vs	1	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:37:57.677
clpa1sjot002wr18pev4fe4vp	clpa1mv29003bva8pq3i4l7vs	1	clp8nklkx000cpo8h7k4km2ou	t	clp8mkal10002po8huax3svf1	2023-11-22 17:37:57.677
clpa1sjot002xr18p5ehn0i4c	clpa1mv29003bva8pq3i4l7vs	1	clp9v8lpf000dpo8hcroabax9	t	clp8mkal10002po8huax3svf1	2023-11-22 17:37:57.677
clpa04ajf0013pu8qpz6aebqx	clpa01h250007va8pxio7jrvp	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:51:06.46
clpa04dyx0015on8qbru34ej1	clpa03eyq000dr18p62t9j1aj	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:51:10.906
clpa1sqc5002ton8q8cjnf5w6	clp8t043k0004po8hwv0zmkbb	4	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 17:38:06.293
clpa1sqc5002uon8qdmn311fe	clp8t043k0004po8hwv0zmkbb	4	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 17:38:06.293
clpa1sqc5002von8qbdd589ix	clp8t043k0004po8hwv0zmkbb	2	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:38:06.293
clpa1tud4004wpu8qfle1s17o	clpa1i7f1002jon8qf29xnxdc	2	clp9vaoeu000gpo8hc77dho1n	t	clp8mkal10002po8huax3svf1	2023-11-22 17:38:58.169
clpa1tud4004xpu8qk8k2562n	clpa1i7f1002jon8qf29xnxdc	3	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 17:38:58.169
clpa1tud4004ypu8qbs3go0se	clpa1i7f1002jon8qf29xnxdc	3	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:38:58.169
clpa1tud4004zpu8qhw89hsum	clpa1i7f1002jon8qf29xnxdc	2	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 17:38:58.169
clpa1vuzd0000po8qujjacns3	clpa1txsa003iva8p03v79bh5	1	clp8nik4o0009po8hsd476r6l	t	clp8mkal10002po8huax3svf1	2023-11-22 17:40:32.281
clpa1vuzd0001po8q9omw2ap9	clpa1txsa003iva8p03v79bh5	7	clp8nhmzq0008po8hzjs7sb5u	t	clp8mkal10002po8huax3svf1	2023-11-22 17:40:32.281
clpa1vuzd0002po8qdfws4kp1	clpa1txsa003iva8p03v79bh5	1	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 17:40:32.281
clpa1vuzd0003po8qlsef4bar	clpa1txsa003iva8p03v79bh5	1	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 17:40:32.281
clpa1x3yf0006po8qv509sltq	clpa1q6n6002jr18pm5p6g9aw	4	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 17:41:30.567
clpa1x3yf0007po8qov06jtdz	clpa1q6n6002jr18pm5p6g9aw	2	clp8ng6zm0006po8hcbqwqbjm	t	clp8mkal10002po8huax3svf1	2023-11-22 17:41:30.567
clpa1x3yf0008po8qgoz0n5iu	clpa1q6n6002jr18pm5p6g9aw	1	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 17:41:30.567
clpa1x3yf0009po8qg7bw5c28	clpa1q6n6002jr18pm5p6g9aw	1	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 17:41:30.567
clpa1x3yf000apo8qk77cx530	clpa1q6n6002jr18pm5p6g9aw	2	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:41:30.567
clpa1y3900052pu8q1jjpdtsm	clpa1vk6q002won8q60cjpj78	1	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 17:42:16.308
clpa1y3900053pu8qynab2940	clpa1vk6q002won8q60cjpj78	1	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 17:42:16.308
clpa1y3900054pu8q9fm5qo0v	clpa1vk6q002won8q60cjpj78	1	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:42:16.308
clpa1y3900055pu8q1sktjr8h	clpa1vk6q002won8q60cjpj78	1	clp8nklkx000cpo8h7k4km2ou	t	clp8mkal10002po8huax3svf1	2023-11-22 17:42:16.308
clpa1y3900056pu8qumv3e5jj	clpa1vk6q002won8q60cjpj78	1	clp8nhmzq0008po8hzjs7sb5u	t	clp8mkal10002po8huax3svf1	2023-11-22 17:42:16.308
clpa1y3900057pu8qttrt6icb	clpa1vk6q002won8q60cjpj78	1	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 17:42:16.308
clpa1y3900058pu8q5b8bambn	clpa1vk6q002won8q60cjpj78	1	clp9v9po8000epo8he4i5uhsi	t	clp8mkal10002po8huax3svf1	2023-11-22 17:42:16.308
clpa1y3900059pu8qatjtkiey	clpa1vk6q002won8q60cjpj78	1	clp9v8lpf000dpo8hcroabax9	t	clp8mkal10002po8huax3svf1	2023-11-22 17:42:16.308
clpa1y390005apu8qebqr9frd	clpa1vk6q002won8q60cjpj78	1	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 17:42:16.308
clpa22bjs002xon8q07km5izi	clpa0s3se004hpu8q67a52qbu	2	clp9vaoeu000gpo8hc77dho1n	t	clp8mkal10002po8huax3svf1	2023-11-22 17:45:33.689
clpa22bjs002yon8qzxqdltvw	clpa0s3se004hpu8q67a52qbu	1	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 17:45:33.689
clpa22bjs002zon8q33subhrb	clpa0s3se004hpu8q67a52qbu	3	clp9va0lv000fpo8h38afr57s	t	clp8mkal10002po8huax3svf1	2023-11-22 17:45:33.689
clpa22bjs0030on8qzekbwc37	clpa0s3se004hpu8q67a52qbu	1	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 17:45:33.689
clpa22bjs0031on8qwnsomqt8	clpa0s3se004hpu8q67a52qbu	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8mkal10002po8huax3svf1	2023-11-22 17:45:33.689
clpa22bjs0032on8qd4x61sqb	clpa0s3se004hpu8q67a52qbu	1	clp8nik4o0009po8hsd476r6l	t	clp8mkal10002po8huax3svf1	2023-11-22 17:45:33.689
clpa22bjs0033on8q81nj23tl	clpa0s3se004hpu8q67a52qbu	1	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:45:33.689
clpa02mxv000son8qbh5l8x29	clpa00xqc0002r18potea6462	1	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 16:49:49.22
clpa02mxv000ton8qow1196tu	clpa00xqc0002r18potea6462	1	clp9v8lpf000dpo8hcroabax9	t	clp8mkal10002po8huax3svf1	2023-11-22 16:49:49.22
clpa02stx000cva8pg91irb5r	clpa01mwv0002q08rxtgei6sy	3	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 16:49:56.853
clpa02stx000dva8p976av7ya	clpa01mwv0002q08rxtgei6sy	2	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:49:56.853
clpa02stx000eva8p2959d03k	clpa01mwv0002q08rxtgei6sy	5	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 16:49:56.853
clpa039nr000yon8q7x5feu2b	clpa00s7j000ion8qiw0j1iib	1	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 16:50:18.664
clpa039nr000zon8ql0k18m1k	clpa00s7j000ion8qiw0j1iib	1	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 16:50:18.664
clpa039nr0010on8qz84sea58	clpa00s7j000ion8qiw0j1iib	1	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 16:50:18.664
clpa039nr0011on8qf433gvhd	clpa00s7j000ion8qiw0j1iib	1	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 16:50:18.664
clpa039nr0012on8q2e9o2bue	clpa00s7j000ion8qiw0j1iib	1	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:50:18.664
clpa03sap000kr18pcp6dsis8	clpa00okz000cpu8qg0bxickx	2	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 16:50:42.817
clpa03sap000lr18pol859scs	clpa00okz000cpu8qg0bxickx	1	clp9va0lv000fpo8h38afr57s	t	clp8mkal10002po8huax3svf1	2023-11-22 16:50:42.817
clpa03sap000mr18pubd8a8fe	clpa00okz000cpu8qg0bxickx	1	clp8nik4o0009po8hsd476r6l	t	clp8mkal10002po8huax3svf1	2023-11-22 16:50:42.817
clpa03sap000nr18p7qhlb6m2	clpa00okz000cpu8qg0bxickx	2	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 16:50:42.817
clpa03sap000or18p3rf4x5ny	clpa00okz000cpu8qg0bxickx	2	clp9v9po8000epo8he4i5uhsi	t	clp8mkal10002po8huax3svf1	2023-11-22 16:50:42.817
clpa03sap000pr18po8vwej2n	clpa00okz000cpu8qg0bxickx	1	clp8nklkx000cpo8h7k4km2ou	t	clp8mkal10002po8huax3svf1	2023-11-22 16:50:42.817
clpa03sap000qr18pjwzhhys1	clpa00okz000cpu8qg0bxickx	1	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 16:50:42.817
clpa04agy000jq08rm9or2h7w	clpa00to50000r18p7w0y4n4f	10	clp8nklkx000cpo8h7k4km2ou	t	clp8mkal10002po8huax3svf1	2023-11-22 16:51:06.371
clpa0bmrb001bq08rs49pahup	clpa00nt90002va8pa1iotpq6	1	clp8nik4o0009po8hsd476r6l	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:48.888
clpa0bmrb001cq08rmsem2y33	clpa00nt90002va8pa1iotpq6	1	clp9va0lv000fpo8h38afr57s	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:48.888
clpa0bmrb001dq08rx31guao5	clpa00nt90002va8pa1iotpq6	2	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:48.888
clpa0bmrb001eq08rn37hs0f1	clpa00nt90002va8pa1iotpq6	1	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:48.888
clpa0bn3p001gq08rl311sse5	clpa091ot001kon8q3ia0d6ot	1	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:49.333
clpa0bn3p001hq08rtwx0n8y6	clpa091ot001kon8q3ia0d6ot	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:49.333
clpa0bn3p001iq08re1qpg4as	clpa091ot001kon8q3ia0d6ot	1	clp9v7rz7000cpo8hj4wekd3i	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:49.333
clpa0bn3p001jq08rvq3xakca	clpa091ot001kon8q3ia0d6ot	1	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:49.333
clpa0bn3p001kq08rjfyc3o1x	clpa091ot001kon8q3ia0d6ot	1	clp9v9po8000epo8he4i5uhsi	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:49.333
clpa0bs7h000wpo8qiic9lgdg	clpa02w1l000uon8qc1c6jqv9	1	clp8nklkx000cpo8h7k4km2ou	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:55.949
clpa0bs7h000xpo8qe9fidah6	clpa02w1l000uon8qc1c6jqv9	2	clp9vaoeu000gpo8hc77dho1n	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:55.949
clpa0bs7h000ypo8q9ytca44l	clpa02w1l000uon8qc1c6jqv9	1	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:55.949
clpa04gv7000kq08rp3c4es6r	clpa0136l000fpu8qjbq4jgph	1	clp8ngr850007po8h7tw98ftt	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:51:14.66
clpa0bs7h000zpo8q0ocixvdz	clpa02w1l000uon8qc1c6jqv9	2	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:55.949
clpa0bs7h0010po8q56nrs116	clpa02w1l000uon8qc1c6jqv9	1	clp8nik4o0009po8hsd476r6l	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:55.949
clpa0bs7h0011po8q7qwyhhg4	clpa02w1l000uon8qc1c6jqv9	1	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:55.949
clpa0bs7h0012po8qb0xctxc1	clpa02w1l000uon8qc1c6jqv9	1	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:55.949
clpa0bs7h0013po8qb49wzvrg	clpa02w1l000uon8qc1c6jqv9	1	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:55.949
clpa0c8up002gpu8qaq8ib3mq	clpa01zqv000mon8q9nbcqysb	1	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 16:57:17.522
clpa0c8up002ipu8q8csnwrcu	clpa01zqv000mon8q9nbcqysb	1	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 16:57:17.522
clpa0c8up002jpu8qfjte9grw	clpa01zqv000mon8q9nbcqysb	1	clp8nhmzq0008po8hzjs7sb5u	t	clp8mkal10002po8huax3svf1	2023-11-22 16:57:17.522
clpa0c8up002kpu8qbaqqszt7	clpa01zqv000mon8q9nbcqysb	2	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 16:57:17.522
clpa0c8up002lpu8qrea8ah4q	clpa01zqv000mon8q9nbcqysb	2	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 16:57:17.522
clpa0c8up002mpu8qfpo6vy5b	clpa01zqv000mon8q9nbcqysb	1	clp9v8lpf000dpo8hcroabax9	t	clp8mkal10002po8huax3svf1	2023-11-22 16:57:17.522
clpa0c8up002npu8qd218w93f	clpa01zqv000mon8q9nbcqysb	1	clp8nklkx000cpo8h7k4km2ou	t	clp8mkal10002po8huax3svf1	2023-11-22 16:57:17.522
clpa0c8up002opu8qmkj3e1kv	clpa01zqv000mon8q9nbcqysb	1	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:57:17.522
clpa0clya002ppu8qzxna8tnj	clpa0c2z4001pr18pkaftww7i	10	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 16:57:34.499
clpa0co87002rpu8qd24zs01e	clpa0a7rg000opo8q8gt0e1h0	1	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:57:37.447
clpa0co87002spu8q5e9ubtnc	clpa0a7rg000opo8q8gt0e1h0	1	clp8nhmzq0008po8hzjs7sb5u	t	clp8mkal10002po8huax3svf1	2023-11-22 16:57:37.447
clpa0co87002tpu8qx2gtz42v	clpa0a7rg000opo8q8gt0e1h0	1	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 16:57:37.447
clpa0co87002upu8q8g87oyuj	clpa0a7rg000opo8q8gt0e1h0	1	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 16:57:37.447
clpa0co87002wpu8q4n91ee76	clpa0a7rg000opo8q8gt0e1h0	1	clp9v9po8000epo8he4i5uhsi	t	clp8mkal10002po8huax3svf1	2023-11-22 16:57:37.447
clpa0co87002xpu8qzipmrbwe	clpa0a7rg000opo8q8gt0e1h0	1	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:57:37.447
clpa0co87002ypu8q1h2wtpoj	clpa0a7rg000opo8q8gt0e1h0	1	clp9v8lpf000dpo8hcroabax9	t	clp8mkal10002po8huax3svf1	2023-11-22 16:57:37.447
clpa0co87002zpu8qso406sbn	clpa0a7rg000opo8q8gt0e1h0	1	clp8nklkx000cpo8h7k4km2ou	t	clp8mkal10002po8huax3svf1	2023-11-22 16:57:37.447
clpa0co870030pu8qt9qdigdw	clpa0a7rg000opo8q8gt0e1h0	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8mkal10002po8huax3svf1	2023-11-22 16:57:37.447
clpa0co870031pu8qh744y5k9	clpa0a7rg000opo8q8gt0e1h0	1	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 16:57:37.447
clpa0cwtj001mon8qvtxafnzu	clpa02l4p000bva8pgsopl9nh	1	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:57:48.583
clpa0cwtj001non8qyvcref7p	clpa02l4p000bva8pgsopl9nh	3	clp8nhmzq0008po8hzjs7sb5u	t	clp8mkal10002po8huax3svf1	2023-11-22 16:57:48.583
clpa0cwtj001oon8qeummiacv	clpa02l4p000bva8pgsopl9nh	1	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 16:57:48.583
clpa0cwtj001pon8queldubbt	clpa02l4p000bva8pgsopl9nh	4	clp9v8lpf000dpo8hcroabax9	t	clp8mkal10002po8huax3svf1	2023-11-22 16:57:48.583
clpa04gv8000lq08rwl4gkpu8	clpa0136l000fpu8qjbq4jgph	2	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 16:51:14.66
clpa04gv8000mq08r4ic9724e	clpa0136l000fpu8qjbq4jgph	2	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 16:51:14.66
clpa04gv8000nq08r73yk8uph	clpa0136l000fpu8qjbq4jgph	1	clp8nklkx000cpo8h7k4km2ou	t	clp8mkal10002po8huax3svf1	2023-11-22 16:51:14.66
clpa04gv8000oq08r5jhfatxm	clpa0136l000fpu8qjbq4jgph	2	clp8nhmzq0008po8hzjs7sb5u	t	clp8mkal10002po8huax3svf1	2023-11-22 16:51:14.66
clpa04gv8000pq08r0u1nvjxu	clpa0136l000fpu8qjbq4jgph	3	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:51:14.66
clpa03h7d000er18plctb2mvm	clpa01o0j0007r18pip0c316p	1	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 16:50:28.441
clpa03h7d000fr18placbworx	clpa01o0j0007r18pip0c316p	1	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:50:28.441
clpa03h7d000gr18p9ti3burr	clpa01o0j0007r18pip0c316p	1	clp9v8lpf000dpo8hcroabax9	t	clp8mkal10002po8huax3svf1	2023-11-22 16:50:28.441
clpa03hfx000ir18ppk1cd7kg	clpa02ro2000fq08rd0zbt2ed	10	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:50:28.749
clpa0cwtj001qon8qak5gq6bs	clpa02l4p000bva8pgsopl9nh	1	clp9v9po8000epo8he4i5uhsi	t	clp8mkal10002po8huax3svf1	2023-11-22 16:57:48.583
clpa0gb9b001rq08rlit30jpg	clpa03rg7000upu8qdh8dpyo1	1	clp9vaoeu000gpo8hc77dho1n	t	clp8mkal10002po8huax3svf1	2023-11-22 17:00:27.263
clpa05o7c0010r18p568k17p6	clpa01jtl0004r18pz4igongi	1	clp8nhmzq0008po8hzjs7sb5u	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:52:10.825
clpa0674p0013r18plrc2almw	clpa04c0q000gva8pxn4r985e	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:52:35.354
clpa068tl000ova8p5l1hg2md	clpa04k7g000qq08rbzle7mly	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:52:37.545
clpa06g63001jpu8qzx6fwb98	clpa0224q0000po8qafaa0r8p	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:52:47.067
clpa06h42000zva8pvg5z5x8e	clpa00tzw0004va8p04skxojt	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:52:48.291
clpa0gb9b001sq08rzwfwp1xw	clpa03rg7000upu8qdh8dpyo1	2	clp8nhmzq0008po8hzjs7sb5u	t	clp8mkal10002po8huax3svf1	2023-11-22 17:00:27.263
clpa0gb9b001tq08ritkirdiu	clpa03rg7000upu8qdh8dpyo1	1	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 17:00:27.263
clpa0gb9b001uq08r3tsjpoze	clpa03rg7000upu8qdh8dpyo1	1	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 17:00:27.263
clpvmxwry0002r18hk7oysw1t	clpvmw87f0000r18h22qkelaj	4	clp8nklkx000cpo8h7k4km2ou	t	clp8mkal10002po8huax3svf1	2023-12-07 20:13:09.55
clpvmxwry0003r18ho0prmzh0	clpvmw87f0000r18h22qkelaj	6	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-12-07 20:13:09.55
clpa0gfc5003epu8qcpfkzvpe	clpa03aqq000gq08ruo68zmmt	3	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:00:32.55
clpa0gfc5003fpu8qv1ssu7id	clpa03aqq000gq08ruo68zmmt	2	clp9v9po8000epo8he4i5uhsi	t	clp8mkal10002po8huax3svf1	2023-11-22 17:00:32.55
clpa0gfc5003gpu8qb8nvwcsm	clpa03aqq000gq08ruo68zmmt	3	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:00:32.55
clpa0gfc5003hpu8q1ved8ilf	clpa03aqq000gq08ruo68zmmt	2	clp9v8lpf000dpo8hcroabax9	t	clp8mkal10002po8huax3svf1	2023-11-22 17:00:32.55
clpa0hcbe001zq08rg4xm2zpr	clpa02de6000eq08rnw7q1tz4	4	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 17:01:15.29
clpa0hcbe0020q08r8742t5hl	clpa02de6000eq08rnw7q1tz4	3	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 17:01:15.29
clpa0hcbe0021q08r9zf3vrk7	clpa02de6000eq08rnw7q1tz4	3	clp9v8lpf000dpo8hcroabax9	t	clp8mkal10002po8huax3svf1	2023-11-22 17:01:15.29
clpa07d8d0000po8qcfz5bs7l	clpa01lxb0009va8pt21eejzu	2	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 16:53:29.918
clpa07d8d0001po8qfojk0231	clpa01lxb0009va8pt21eejzu	1	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 16:53:29.918
clpa07d8d0002po8q5c0thfhc	clpa01lxb0009va8pt21eejzu	1	clp8nhmzq0008po8hzjs7sb5u	t	clp8mkal10002po8huax3svf1	2023-11-22 16:53:29.918
clpa07d8d0003po8q1kadg24c	clpa01lxb0009va8pt21eejzu	1	clp8nik4o0009po8hsd476r6l	t	clp8mkal10002po8huax3svf1	2023-11-22 16:53:29.918
clpa07d8d0004po8q6tjl5ea7	clpa01lxb0009va8pt21eejzu	2	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:53:29.918
clpa07d8d0005po8qfj6vz7ql	clpa01lxb0009va8pt21eejzu	2	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 16:53:29.918
clpa07d8d0006po8q9lj021af	clpa01lxb0009va8pt21eejzu	1	clp9vaoeu000gpo8hc77dho1n	t	clp8mkal10002po8huax3svf1	2023-11-22 16:53:29.918
clpvmxwrz0004r18ht25sytw2	clpvmw87f0000r18h22qkelaj	1	clp8mq9mz0004po8h2r00xlaj	f	clp8movr40003po8hk44ct7ez	2023-12-07 20:13:09.552
clpa0am8o001ir18pr3k42zr6	clpa020ox000oon8q5sr2fxpm	2	clp9v8lpf000dpo8hcroabax9	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:01.561
clpa0am8p001jr18p2t0mpgtz	clpa020ox000oon8q5sr2fxpm	4	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:01.561
clpa0am8p001kr18pzyokpsh6	clpa020ox000oon8q5sr2fxpm	2	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:01.561
clpa0am8p001lr18pur57wixm	clpa020ox000oon8q5sr2fxpm	2	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:01.561
clpa0b0kf0026pu8qsgxlspet	clpa0a6mh0016q08rbcerl6hi	1	clp8nhmzq0008po8hzjs7sb5u	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:20.128
clpa0hn35002bva8pdtzpgryf	clpa08zq9001ion8qb39zwl64	1	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 17:01:29.249
clpa0hn35002cva8p144hyhrz	clpa08zq9001ion8qb39zwl64	1	clp8nhmzq0008po8hzjs7sb5u	t	clp8mkal10002po8huax3svf1	2023-11-22 17:01:29.249
clpa0hn35002dva8pvg7urnqu	clpa08zq9001ion8qb39zwl64	2	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:01:29.249
clpa0hn35002eva8plc4tzi69	clpa08zq9001ion8qb39zwl64	1	clp9v8lpf000dpo8hcroabax9	t	clp8mkal10002po8huax3svf1	2023-11-22 17:01:29.249
clpa0hn35002fva8pka78disk	clpa08zq9001ion8qb39zwl64	1	clp8nklkx000cpo8h7k4km2ou	t	clp8mkal10002po8huax3svf1	2023-11-22 17:01:29.249
clpa0hn35002gva8pm49ffyol	clpa08zq9001ion8qb39zwl64	1	clp9va0lv000fpo8h38afr57s	t	clp8mkal10002po8huax3svf1	2023-11-22 17:01:29.249
clpa0hn35002hva8ptmzudxmt	clpa08zq9001ion8qb39zwl64	2	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 17:01:29.249
clpa09nxd001er18pks7cbu3h	clpa044ja000xpu8q3gwmltvy	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:55:17.089
clpa09u7e0021pu8qolbrnkks	clp8spbr10003po8hhi15pg8r	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:55:25.227
clpa0am2i001hr18pnf9gmyhs	clp8pe6na0005po8h4fyc9nz6	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:56:01.338
clpa0hn35002iva8po5sc0h55	clpa08zq9001ion8qb39zwl64	1	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 17:01:29.249
clpa0j2tx001rr18pi6d22nt8	clpa0gqmr002ava8pyx5n2vi1	3	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 17:02:36.31
clpa0j2tx001sr18pesl9p323	clpa0gqmr002ava8pyx5n2vi1	5	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:02:36.31
clpa0j2tx001tr18pime6xrsf	clpa0gqmr002ava8pyx5n2vi1	2	clp9v8lpf000dpo8hcroabax9	t	clp8mkal10002po8huax3svf1	2023-11-22 17:02:36.31
clpa0j3ha001wr18p3ygkw18y	clpa0du8o001mq08raus3uucs	3	clp8nhmzq0008po8hzjs7sb5u	t	clp8mkal10002po8huax3svf1	2023-11-22 17:02:37.15
clpa0j3ha001xr18p9mxzqo1q	clpa0du8o001mq08raus3uucs	3	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 17:02:37.15
clpa0j3ha001yr18pyoagwmhx	clpa0du8o001mq08raus3uucs	3	clp9vaoeu000gpo8hc77dho1n	t	clp8mkal10002po8huax3svf1	2023-11-22 17:02:37.15
clpa0j3ha001zr18pk5anbc27	clpa0du8o001mq08raus3uucs	1	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 17:02:37.15
clpa0jpmh003jpu8qbfc5b2c6	clpa0db480020va8pssnhknlj	2	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 17:03:05.849
clpa0jpmh003kpu8q4t4tbmca	clpa0db480020va8pssnhknlj	2	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:03:05.849
clpa0jpmh003lpu8qmbvxeyjf	clpa0db480020va8pssnhknlj	1	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 17:03:05.849
clpa0jpmh003mpu8qdlunfu2y	clpa0db480020va8pssnhknlj	1	clp9va0lv000fpo8h38afr57s	t	clp8mkal10002po8huax3svf1	2023-11-22 17:03:05.849
clpa0jpmh003npu8qbe80w3le	clpa0db480020va8pssnhknlj	2	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:03:05.849
clpa0jpmh003opu8qj7qlwxmx	clpa0db480020va8pssnhknlj	2	clp8ng6zm0006po8hcbqwqbjm	t	clp8mkal10002po8huax3svf1	2023-11-22 17:03:05.849
clpa0lcef003rpu8qk5dujokn	clpa0ekez0022va8pmq3kaigy	3	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 17:04:22.024
clpa0lcef003spu8qvdymha94	clpa0ekez0022va8pmq3kaigy	4	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 17:04:22.024
clpa0lcef003tpu8q7slk69d1	clpa0ekez0022va8pmq3kaigy	1	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 17:04:22.024
clpa0lcef003upu8qz8hoiq69	clpa0ekez0022va8pmq3kaigy	1	clp9v9po8000epo8he4i5uhsi	t	clp8mkal10002po8huax3svf1	2023-11-22 17:04:22.024
clpa0lcef003vpu8qkv944qbb	clpa0ekez0022va8pmq3kaigy	1	clp8nklkx000cpo8h7k4km2ou	t	clp8mkal10002po8huax3svf1	2023-11-22 17:04:22.024
clpa0rhu7004cpu8q04bkiuph	clpa0nh95002mva8pngzxzeag	1	clp9v7rz7000cpo8hj4wekd3i	t	clp8mkal10002po8huax3svf1	2023-11-22 17:09:09.007
clpa0rhu7004dpu8qczi5m52j	clpa0nh95002mva8pngzxzeag	1	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:09:09.007
clpa0rhu7004epu8qvyh05olu	clpa0nh95002mva8pngzxzeag	1	clp9v8lpf000dpo8hcroabax9	t	clp8mkal10002po8huax3svf1	2023-11-22 17:09:09.007
clpa0rhu7004fpu8quc967bpw	clpa0nh95002mva8pngzxzeag	1	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 17:09:09.007
clpa0zlq70002po8q93yi3m30	clpa0xeub0023on8qhui1ja4f	2	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:15:27.295
clpa0zlq70003po8qyb1chfdq	clpa0xeub0023on8qhui1ja4f	2	clp8nklkx000cpo8h7k4km2ou	t	clp8mkal10002po8huax3svf1	2023-11-22 17:15:27.295
clpa09kq9000kpo8q5jojq35v	clpa08fz40013q08rxe1oo02u	3	clp8nklkx000cpo8h7k4km2ou	t	clp8mkal10002po8huax3svf1	2023-11-22 16:55:12.946
clpa09kq9000lpo8quyhpfvy3	clpa08fz40013q08rxe1oo02u	3	clp9v7rz7000cpo8hj4wekd3i	t	clp8mkal10002po8huax3svf1	2023-11-22 16:55:12.946
clpa09kq9000mpo8qx4gxw69w	clpa08fz40013q08rxe1oo02u	1	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 16:55:12.946
clpa09nxc0017r18p19a830f5	clpa044ja000xpu8q3gwmltvy	2	clp8ng6zm0006po8hcbqwqbjm	t	clp8mkal10002po8huax3svf1	2023-11-22 16:55:17.089
clpa0a2by001ova8piyq0tvin	clpa06k0c001kpu8qc7mid9cs	3	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 16:55:35.758
clpa0a2by001pva8po01xcsuh	clpa06k0c001kpu8qc7mid9cs	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8mkal10002po8huax3svf1	2023-11-22 16:55:35.758
clpa0a2by001qva8p8fahd5sv	clpa06k0c001kpu8qc7mid9cs	1	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:55:35.758
clpa0a2by001rva8p18xvo17e	clpa06k0c001kpu8qc7mid9cs	1	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 16:55:35.758
clpa0adqc001tva8pa1letk7f	clpa08ntf000gpo8q0qnm6cf3	3	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 16:55:50.532
clpa0adqc001uva8psi4en0ju	clpa08ntf000gpo8q0qnm6cf3	3	clp8ng6zm0006po8hcbqwqbjm	t	clp8mkal10002po8huax3svf1	2023-11-22 16:55:50.532
clpa0adqc001vva8pnm6a5g9h	clpa08ntf000gpo8q0qnm6cf3	1	clp8nklkx000cpo8h7k4km2ou	t	clp8mkal10002po8huax3svf1	2023-11-22 16:55:50.532
clpa0adqc001wva8pb6bfdeor	clpa08ntf000gpo8q0qnm6cf3	1	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:55:50.532
clpa0adqc001xva8p0oc632qx	clpa08ntf000gpo8q0qnm6cf3	1	clp9v8lpf000dpo8hcroabax9	t	clp8mkal10002po8huax3svf1	2023-11-22 16:55:50.532
clpa0adqc001yva8p4qkmcw7x	clpa08ntf000gpo8q0qnm6cf3	1	clp9v9po8000epo8he4i5uhsi	t	clp8mkal10002po8huax3svf1	2023-11-22 16:55:50.532
clpa10e4v002uq08rz6ji094h	clpa0z8y80028r18p8ce34l69	6	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 17:16:04.112
clpa10e4v002vq08rs11kpr2u	clpa0z8y80028r18p8ce34l69	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8mkal10002po8huax3svf1	2023-11-22 17:16:04.112
clpa10e4v002wq08rk2flo48k	clpa0z8y80028r18p8ce34l69	1	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:16:04.112
clpa10e4v002xq08rjfujo72o	clpa0z8y80028r18p8ce34l69	2	clp8nik4o0009po8hsd476r6l	t	clp8mkal10002po8huax3svf1	2023-11-22 17:16:04.112
clpa12opx002uva8p74c1rynz	clpa118o7002yq08rvqp1ukij	1	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 17:17:51.141
clpa14wu90029r18p2oxde5ym	clpa0p0ds0025q08r62i7l70z	10	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 17:19:34.978
clpa17e0q002cr18plqoh0e61	clpa165ne002br18pac1d3bzj	3	clp9vaoeu000gpo8hc77dho1n	t	clp8mkal10002po8huax3svf1	2023-11-22 17:21:30.555
clpa17e0q002dr18prjox6gy9	clpa165ne002br18pac1d3bzj	2	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 17:21:30.555
clpa17e0q002er18p3bo13z2o	clpa165ne002br18pac1d3bzj	1	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:21:30.555
clpa17e0q002fr18p6m0peqgn	clpa165ne002br18pac1d3bzj	2	clp8nklkx000cpo8h7k4km2ou	t	clp8mkal10002po8huax3svf1	2023-11-22 17:21:30.555
clpa17e0q002gr18plurffwm2	clpa165ne002br18pac1d3bzj	2	clp8nik4o0009po8hsd476r6l	t	clp8mkal10002po8huax3svf1	2023-11-22 17:21:30.555
clpa17fj6004npu8qj7bla53q	clpa02390000cq08rurrbh3oo	5	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 17:21:32.514
clpa17fj6004opu8qf6pn1ixc	clpa02390000cq08rurrbh3oo	2	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:21:32.514
clpa17fj6004ppu8q7cigw4y6	clpa02390000cq08rurrbh3oo	3	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:21:32.514
clpa19zqa0028on8qo04a41nq	clpa1992w002ir18pggihja2o	5	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 17:23:32.002
clpa19zqa0029on8q2m0gvl1t	clpa1992w002ir18pggihja2o	2	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 17:23:32.002
clpa19zqa002aon8qbwig5c7m	clpa1992w002ir18pggihja2o	3	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 17:23:32.002
clpa1aj7a002zq08rjc3mkbj6	clpa17k830027on8qzaet9vq3	1	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:23:57.239
clpa1dsef0001po8qpu1tk82l	clpa1bg330031q08rodho385b	1	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 17:26:29.127
clpa1dsef0002po8qhq4a9ci5	clpa1bg330031q08rodho385b	1	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 17:26:29.127
clpa1dsef0003po8qzyh038iw	clpa1bg330031q08rodho385b	3	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:26:29.127
clpa1dsef0004po8qlqdjjp2y	clpa1bg330031q08rodho385b	2	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 17:26:29.127
clpa1dsef0005po8qtwwlqne8	clpa1bg330031q08rodho385b	1	clp9va0lv000fpo8h38afr57s	t	clp8mkal10002po8huax3svf1	2023-11-22 17:26:29.127
clpa1dsef0006po8qha8e7itd	clpa1bg330031q08rodho385b	1	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 17:26:29.127
clpa1dsef0007po8q8qwpr7cf	clpa1bg330031q08rodho385b	1	clp9v8lpf000dpo8hcroabax9	t	clp8mkal10002po8huax3svf1	2023-11-22 17:26:29.127
clpa09u7e001ypu8qxx8ssc0p	clp8spbr10003po8hhi15pg8r	4	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 16:55:25.227
clpa09u7e001zpu8qc0t1w9oe	clp8spbr10003po8hhi15pg8r	5	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:55:25.227
clpa09u7e0020pu8q6qq7bcj7	clp8spbr10003po8hhi15pg8r	1	clp9vaoeu000gpo8hc77dho1n	t	clp8mkal10002po8huax3svf1	2023-11-22 16:55:25.227
clpa07i9b0009po8qnrdz524d	clpa01e40000lon8qhxnthv1h	1	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 16:53:36.432
clpa07i9b000apo8qa7rytqv6	clpa01e40000lon8qhxnthv1h	2	clp8ng6zm0006po8hcbqwqbjm	t	clp8mkal10002po8huax3svf1	2023-11-22 16:53:36.432
clpa07i9b000bpo8q89oxi21b	clpa01e40000lon8qhxnthv1h	2	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:53:36.432
clpa07i9b000cpo8qv0c8qecz	clpa01e40000lon8qhxnthv1h	1	clp8nhmzq0008po8hzjs7sb5u	t	clp8mkal10002po8huax3svf1	2023-11-22 16:53:36.432
clpa07i9b000dpo8qcj9xzjf1	clpa01e40000lon8qhxnthv1h	2	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 16:53:36.432
clpa07i9b000epo8q97ehfx0g	clpa01e40000lon8qhxnthv1h	1	clp9v9po8000epo8he4i5uhsi	t	clp8mkal10002po8huax3svf1	2023-11-22 16:53:36.432
clpa0a2by001sva8pqx6o4jfj	clpa06k0c001kpu8qc7mid9cs	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:55:35.759
clpa07i9b000fpo8q17te8whs	clpa01e40000lon8qhxnthv1h	1	clp8nik4o0009po8hsd476r6l	t	clp8mkal10002po8huax3svf1	2023-11-22 16:53:36.432
clpa083jp0010va8pgjoamwum	clpa062wi000nva8pfdrxhlb6	3	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:04.021
clpa083jp0011va8p0re2pmg1	clpa062wi000nva8pfdrxhlb6	2	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:04.021
clpa083jp0012va8pfugwbh5t	clpa062wi000nva8pfdrxhlb6	3	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:04.021
clpa083jp0013va8p4jxoo3jd	clpa062wi000nva8pfdrxhlb6	1	clp8nklkx000cpo8h7k4km2ou	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:04.021
clpa083jp0014va8pjpwpu0xn	clpa062wi000nva8pfdrxhlb6	1	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:04.021
clpa08dp70016va8pct4q61v8	clpa05xas001bpu8qxgljvnf5	1	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:17.179
clpa08dp70017va8p9gpdowfr	clpa05xas001bpu8qxgljvnf5	1	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:17.179
clpa08dp70018va8pxynl3z4b	clpa05xas001bpu8qxgljvnf5	1	clp9v7rz7000cpo8hj4wekd3i	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:17.179
clpa08dp70019va8phg6ireq5	clpa05xas001bpu8qxgljvnf5	4	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:17.179
clpa08dp7001ava8p60fxmypa	clpa05xas001bpu8qxgljvnf5	1	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:17.179
clpa08dp7001bva8pf248te9f	clpa05xas001bpu8qxgljvnf5	1	clp9v8lpf000dpo8hcroabax9	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:17.179
clpa08dp7001cva8prkery1uv	clpa05xas001bpu8qxgljvnf5	1	clp8nklkx000cpo8h7k4km2ou	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:17.179
clpa08ekz001eva8puzahwrk2	clpa05mvm001apu8qw98jfov8	3	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:18.324
clpa08ekz001fva8poio1eh8m	clpa05mvm001apu8qw98jfov8	2	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:18.324
clpa08ekz001gva8ph4pmqugh	clpa05mvm001apu8qw98jfov8	2	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:18.324
clpa08ekz001hva8p381pwnyr	clpa05mvm001apu8qw98jfov8	2	clp9v7rz7000cpo8hj4wekd3i	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:18.324
clpa08ekz001iva8pw0jfmtbw	clpa05mvm001apu8qw98jfov8	1	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:18.324
clpa08oc5001aon8qfgw8kfpu	clp8npp76000fpo8h8i8cf5sz	1	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:30.965
clpa08oc5001bon8qpieolvsk	clp8npp76000fpo8h8i8cf5sz	3	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:30.965
clpa08oc5001con8qoo6cip5m	clp8npp76000fpo8h8i8cf5sz	2	clp9v9po8000epo8he4i5uhsi	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:30.965
clpa08oc5001don8qolxufyfs	clp8npp76000fpo8h8i8cf5sz	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:30.965
clpa08oc5001eon8qd9q8fite	clp8npp76000fpo8h8i8cf5sz	1	clp9va0lv000fpo8h38afr57s	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:30.965
clpa08oc5001fon8q36fvni70	clp8npp76000fpo8h8i8cf5sz	1	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:30.965
clpa08oc5001gon8qbafcwr6o	clp8npp76000fpo8h8i8cf5sz	1	clp9v7rz7000cpo8hj4wekd3i	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:30.965
clpa08ptv001rpu8qynmvu38s	clpa07dtr001qpu8qzf6gyw3o	1	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:32.899
clpa08ptv001spu8qjgot9kl1	clpa07dtr001qpu8qzf6gyw3o	2	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:32.899
clpa08ptv001tpu8qj8vyj1z8	clpa07dtr001qpu8qzf6gyw3o	3	clp9va0lv000fpo8h38afr57s	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:32.899
clpa08ptv001upu8qgiyxp0f4	clpa07dtr001qpu8qzf6gyw3o	4	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:32.899
clpa092b8001kva8p84gy0lrn	clpa07bgk0012q08r4hz0xrxm	4	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:49.076
clpa092b8001lva8pjgdg2d6p	clpa07bgk0012q08r4hz0xrxm	2	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:49.076
clpa092b8001mva8psp1dhvy9	clpa07bgk0012q08r4hz0xrxm	4	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 16:54:49.076
clpa09kq9000jpo8qlc8u79pv	clpa08fz40013q08rxe1oo02u	3	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 16:55:12.946
clpa09nxc0018r18phmhkg2yt	clpa044ja000xpu8q3gwmltvy	1	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:55:17.089
clpa09nxc0019r18pr8f0zt71	clpa044ja000xpu8q3gwmltvy	2	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 16:55:17.089
clpa09nxc001ar18p96mq8ri9	clpa044ja000xpu8q3gwmltvy	1	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 16:55:17.089
clpa09nxc001br18pafcjtzru	clpa044ja000xpu8q3gwmltvy	1	clp9v9po8000epo8he4i5uhsi	t	clp8mkal10002po8huax3svf1	2023-11-22 16:55:17.089
clpa09nxc001cr18piglv179u	clpa044ja000xpu8q3gwmltvy	2	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 16:55:17.089
clpa09nxc001dr18ppafkcc44	clpa044ja000xpu8q3gwmltvy	1	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 16:55:17.089
clpa0am2i001fr18pnl9nsvq9	clp8pe6na0005po8h4fyc9nz6	5	clp9vaoeu000gpo8hc77dho1n	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:01.338
clpa0adqd001zva8p7v2zso2m	clpa08ntf000gpo8q0qnm6cf3	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:55:50.533
clpa0am8q001mr18pofyvmxjo	clpa020ox000oon8q5sr2fxpm	1	clp8nlysu000epo8hfkh22xyr	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:56:01.562
clpa0b0kf0027pu8qnxpb1sut	clpa0a6mh0016q08rbcerl6hi	1	clp8nhmzq0008po8hzjs7sb5u	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:56:20.128
clpa0am2i001gr18phq1ksewu	clp8pe6na0005po8h4fyc9nz6	5	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:01.338
clpa0bgsd0029pu8qbvntuwct	clpa0301q000won8q30lomd3h	3	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:41.149
clpa0bgsd002apu8q9mk8pmak	clpa0301q000won8q30lomd3h	1	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:41.149
clpa0bgsd002bpu8q3nfh73ej	clpa0301q000won8q30lomd3h	1	clp8nhmzq0008po8hzjs7sb5u	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:41.149
clpa0bgsd002cpu8q1etozrum	clpa0301q000won8q30lomd3h	2	clp9v8lpf000dpo8hcroabax9	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:41.149
clpa0bgsd002dpu8qix9en87f	clpa0301q000won8q30lomd3h	1	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:41.149
clpa0bgsd002epu8q1iu4pkfn	clpa0301q000won8q30lomd3h	1	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:41.149
clpa0bgsd002fpu8qlzoxiwsk	clpa0301q000won8q30lomd3h	1	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:41.149
clpa04yzy000sq08rkzdb3dy3	clpa01nri0006r18pfqadsrpv	2	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 16:51:38.159
clpa04yzy000tq08ri15y7o1m	clpa01nri0006r18pfqadsrpv	2	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 16:51:38.159
clpa04yzy000uq08rm5nxfrid	clpa01nri0006r18pfqadsrpv	1	clp9va0lv000fpo8h38afr57s	t	clp8mkal10002po8huax3svf1	2023-11-22 16:51:38.159
clpa04yzy000vq08ra8hwfs1n	clpa01nri0006r18pfqadsrpv	1	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 16:51:38.159
clpa04yzy000wq08rx8xfmie9	clpa01nri0006r18pfqadsrpv	2	clp9v9po8000epo8he4i5uhsi	t	clp8mkal10002po8huax3svf1	2023-11-22 16:51:38.159
clpa04yzy000xq08r5rkusonr	clpa01nri0006r18pfqadsrpv	1	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:51:38.159
clpa04yzy000yq08rf1ik6g92	clpa01nri0006r18pfqadsrpv	1	clp9v7rz7000cpo8hj4wekd3i	t	clp8mkal10002po8huax3svf1	2023-11-22 16:51:38.159
clpa05lj30014pu8q9s02n33h	clpa01ygj000jpu8qcxdxprj4	2	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:07.36
clpa05lj30015pu8qcvyqr271	clpa01ygj000jpu8qcxdxprj4	2	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:07.36
clpa05lj30016pu8q67ogzt36	clpa01ygj000jpu8qcxdxprj4	1	clp8nhmzq0008po8hzjs7sb5u	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:07.36
clpa05lj30017pu8qt1yv31u8	clpa01ygj000jpu8qcxdxprj4	2	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:07.36
clpa05lj30018pu8q7elz4xyl	clpa01ygj000jpu8qcxdxprj4	3	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:07.36
clpa05mv7000hva8pmpjmi0pq	clpa035zv000tpu8q4mqdtjf4	3	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:09.091
clpa05mv7000iva8pohaoiq63	clpa035zv000tpu8q4mqdtjf4	3	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:09.091
clpa05mv7000jva8pm3zyge7n	clpa035zv000tpu8q4mqdtjf4	1	clp8nklkx000cpo8h7k4km2ou	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:09.091
clpa05mv7000kva8pksgtr1k2	clpa035zv000tpu8q4mqdtjf4	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:09.091
clpa05mv7000lva8pbu8jwzbk	clpa035zv000tpu8q4mqdtjf4	2	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:09.091
clpa05o7c000sr18pfkiijh92	clpa01jtl0004r18pz4igongi	2	clp8ng6zm0006po8hcbqwqbjm	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:10.824
clpa05o7c000tr18pb38j4elz	clpa01jtl0004r18pz4igongi	1	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:10.824
clpa05o7c000ur18pycqwse15	clpa01jtl0004r18pz4igongi	1	clp9va0lv000fpo8h38afr57s	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:10.824
clpa05o7c000vr18pwujvarjw	clpa01jtl0004r18pz4igongi	1	clp8nik4o0009po8hsd476r6l	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:10.824
clpa05o7c000wr18pxsuzzqxe	clpa01jtl0004r18pz4igongi	1	clp8nhmzq0008po8hzjs7sb5u	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:10.824
clpa05o7c000xr18prgf8uqfn	clpa01jtl0004r18pz4igongi	1	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:10.824
clpa05o7c000yr18pdzrkypjp	clpa01jtl0004r18pz4igongi	1	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:10.824
clpa05o7c000zr18p6anftpob	clpa01jtl0004r18pz4igongi	2	clp9v8lpf000dpo8hcroabax9	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:10.824
clpa0674q0014r18pc6vsi3x8	clpa04c0q000gva8pxn4r985e	5	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:35.354
clpa0674q0015r18p9x9untjn	clpa04c0q000gva8pxn4r985e	3	clp9v8lpf000dpo8hcroabax9	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:35.354
clpa0674q0016r18p4yn8rxa3	clpa04c0q000gva8pxn4r985e	2	clp9va0lv000fpo8h38afr57s	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:35.354
clpa068tm000pva8phlxfc07w	clpa04k7g000qq08rbzle7mly	5	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:37.547
clpa068tm000qva8pqu5f6wk3	clpa04k7g000qq08rbzle7mly	4	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:37.547
clpa068tm000rva8p9ose6cxx	clpa04k7g000qq08rbzle7mly	1	clp8nhmzq0008po8hzjs7sb5u	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:37.547
clpa06g63001dpu8qbe6e4o1b	clpa0224q0000po8qafaa0r8p	3	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:47.067
clpa06g63001epu8q1v7qu9v4	clpa0224q0000po8qafaa0r8p	2	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:47.067
clpa06g63001fpu8qdr95ii63	clpa0224q0000po8qafaa0r8p	2	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:47.067
clpa06g63001gpu8q5zhj9ljj	clpa0224q0000po8qafaa0r8p	1	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:47.067
clpa06g63001hpu8qi4jwkw8y	clpa0224q0000po8qafaa0r8p	1	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:47.067
clpa06g63001ipu8qfe32r1ec	clpa0224q0000po8qafaa0r8p	1	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:47.067
clpa06h42000sva8pj9ku0pyn	clpa00tzw0004va8p04skxojt	2	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:48.29
clpa06h42000tva8pxp5uk55r	clpa00tzw0004va8p04skxojt	1	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:48.29
clpa0bgsd0028pu8qlwnzlzjb	clpa0301q000won8q30lomd3h	1	clp8ngr850007po8h7tw98ftt	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:56:41.149
clpa06h42000uva8ps22zp27k	clpa00tzw0004va8p04skxojt	2	clp9v8lpf000dpo8hcroabax9	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:48.29
clpa06h42000vva8pxiqxuqwz	clpa00tzw0004va8p04skxojt	1	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:48.29
clpa06h42000wva8p3uu1xmhw	clpa00tzw0004va8p04skxojt	2	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:48.29
clpa06h42000xva8peh4c03xi	clpa00tzw0004va8p04skxojt	1	clp9v9po8000epo8he4i5uhsi	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:48.29
clpa06h42000yva8pad3vrsqb	clpa00tzw0004va8p04skxojt	1	clp8nklkx000cpo8h7k4km2ou	t	clp8mkal10002po8huax3svf1	2023-11-22 16:52:48.29
clpa079pr001mpu8q551gtjlw	clpa03yui0014on8qer2lnf41	4	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 16:53:25.36
clpa079pr001npu8qbmv47oco	clpa03yui0014on8qer2lnf41	4	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 16:53:25.36
clpa079pr001opu8qnxosyl3h	clpa03yui0014on8qer2lnf41	2	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:53:25.36
clpa0bl7e000rpo8ql9gy4kk1	clpa02d83000npu8qn5j6y94f	3	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:46.874
clpa0bl7e000spo8q4vwfxog7	clpa02d83000npu8qn5j6y94f	2	clp8nhmzq0008po8hzjs7sb5u	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:46.874
clpa0bl7e000tpo8qz7uu4ujl	clpa02d83000npu8qn5j6y94f	2	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:46.874
clpa0bl7e000upo8qvtjimal1	clpa02d83000npu8qn5j6y94f	2	clp8ng6zm0006po8hcbqwqbjm	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:46.874
clpa0bl7e000vpo8qldfniufc	clpa02d83000npu8qn5j6y94f	1	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:46.874
clpa0bmrb0019q08rigip7hkc	clpa00nt90002va8pa1iotpq6	4	clp9v8lpf000dpo8hcroabax9	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:48.888
clpa0bmrb001aq08rqm4g7mmg	clpa00nt90002va8pa1iotpq6	1	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:56:48.888
clpa2gftw0099pu8qrsra1d1t	clpa2fjyz0068q08rzsi1dasm	1	clp9va0lv000fpo8h38afr57s	t	clp8mkal10002po8huax3svf1	2023-11-22 17:56:32.421
clpa2gftw009apu8qrnbhpjhq	clpa2fjyz0068q08rzsi1dasm	1	clp8nklkx000cpo8h7k4km2ou	t	clp8mkal10002po8huax3svf1	2023-11-22 17:56:32.421
clpa0cwtk001ron8qf27oo60q	clpa02l4p000bva8pgsopl9nh	1	clp8nhmzq0008po8hzjs7sb5u	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:57:48.584
clpa0czug001son8q9b2l27q5	clpa0c84h0016po8qg102t7zm	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:57:52.504
clpa2llep009epu8qebn8xh5l	clpa2knir0069q08r42rstb2r	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8movr40003po8hk44ct7ez	2023-11-22 18:00:32.929
clpa0czug001ton8ql0mg7ara	clpa0c84h0016po8qg102t7zm	5	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 16:57:52.505
clpa0czug001uon8qhpm43v71	clpa0c84h0016po8qg102t7zm	5	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 16:57:52.505
clpa2gftx009bpu8qzod9l7uj	clpa2fjyz0068q08rzsi1dasm	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:56:32.421
clpa2llep009cpu8q97cz7p8l	clpa2knir0069q08r42rstb2r	5	clp9va0lv000fpo8h38afr57s	t	clp8mkal10002po8huax3svf1	2023-11-22 18:00:32.929
clpa2llep009dpu8q34zw68n2	clpa2knir0069q08r42rstb2r	5	clp8nklkx000cpo8h7k4km2ou	t	clp8mkal10002po8huax3svf1	2023-11-22 18:00:32.929
clpa0e1f40032pu8qtg2beqxw	clpa0a0cw000npo8qiu1on24h	1	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:58:41.2
clpa0es190024va8pign3zsn8	clpa067b80019on8qt7xy3lfg	5	clp8nhmzq0008po8hzjs7sb5u	t	clp8mkal10002po8huax3svf1	2023-11-22 16:59:15.694
clpa0es190025va8pm1db6np8	clpa067b80019on8qt7xy3lfg	2	clp8ng6zm0006po8hcbqwqbjm	t	clp8mkal10002po8huax3svf1	2023-11-22 16:59:15.694
clpa0e1f40033pu8qptky3ny3	clpa0a0cw000npo8qiu1on24h	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:58:41.201
clpa0es1e0029va8pq4g5luv8	clpa067b80019on8qt7xy3lfg	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:59:15.699
clpa0gfc5003ipu8qj3cbmk6l	clpa03aqq000gq08ruo68zmmt	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:00:32.55
clpa0es190026va8p7er3tla2	clpa067b80019on8qt7xy3lfg	1	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 16:59:15.694
clpa0es190027va8pkgbrylt3	clpa067b80019on8qt7xy3lfg	1	clp9v9po8000epo8he4i5uhsi	t	clp8mkal10002po8huax3svf1	2023-11-22 16:59:15.694
clpa0es190028va8px1rynqrs	clpa067b80019on8qt7xy3lfg	1	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 16:59:15.694
clpa0fmin0036pu8ql0jddurb	clpa0c0ap0015po8qy56ztfi3	2	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 16:59:55.2
clpa0fmin0037pu8qkq79gvsw	clpa0c0ap0015po8qy56ztfi3	1	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 16:59:55.2
clpa0fmin0038pu8qad7apqbq	clpa0c0ap0015po8qy56ztfi3	1	clp8nhmzq0008po8hzjs7sb5u	t	clp8mkal10002po8huax3svf1	2023-11-22 16:59:55.2
clpa0fmin0039pu8qlei1rxl6	clpa0c0ap0015po8qy56ztfi3	2	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 16:59:55.2
clpa0fmin003bpu8qtpvkkuzd	clpa0c0ap0015po8qy56ztfi3	1	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 16:59:55.2
clpa0fmin003cpu8qi37v96oy	clpa0c0ap0015po8qy56ztfi3	2	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 16:59:55.2
clpa0fmin003dpu8qh2fptu0e	clpa0c0ap0015po8qy56ztfi3	1	clp9v8lpf000dpo8hcroabax9	t	clp8mkal10002po8huax3svf1	2023-11-22 16:59:55.2
clpa0gb9b001pq08r6qvclgx7	clpa03rg7000upu8qdh8dpyo1	3	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:00:27.263
clpa0gb9b001qq08r6jshfztb	clpa03rg7000upu8qdh8dpyo1	2	clp9va0lv000fpo8h38afr57s	t	clp8mkal10002po8huax3svf1	2023-11-22 17:00:27.263
clpa0lttv0024q08rn1uaa22z	clpa0l7jl0022q08rrreztqoe	10	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 17:04:44.611
clpa0mfwc0020r18pkclpi92o	clpa0g196001nq08r2uca7f63	1	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 17:05:13.213
clpa0mfwc0021r18p5sad5mf3	clpa0g196001nq08r2uca7f63	1	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 17:05:13.213
clpa0mfwc0022r18py972hxea	clpa0g196001nq08r2uca7f63	1	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:05:13.213
clpa0mfwc0023r18pslnvtdit	clpa0g196001nq08r2uca7f63	1	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 17:05:13.213
clpa2eu50004nr18pt2udspo5	clpa2e549008qpu8qxz6pkw6h	1	clp8nj655000apo8hwwssxkqr	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:55:17.652
clpa0mfwc0024r18pcei53fic	clpa0g196001nq08r2uca7f63	1	clp8nhmzq0008po8hzjs7sb5u	t	clp8mkal10002po8huax3svf1	2023-11-22 17:05:13.213
clpa0s1fz002fq08r7qbiwdt2	clpa0pwol0006po8qkekhb7yz	3	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:09:34.415
clpa0s1fz002gq08r5luw5tlt	clpa0pwol0006po8qkekhb7yz	2	clp9v8lpf000dpo8hcroabax9	t	clp8mkal10002po8huax3svf1	2023-11-22 17:09:34.415
clpa0s1fz002hq08rwqxdqsg2	clpa0pwol0006po8qkekhb7yz	1	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 17:09:34.415
clpa0s1fz002iq08r5n6xjiid	clpa0pwol0006po8qkekhb7yz	1	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 17:09:34.415
clpa0s1fz002jq08rcrnynudv	clpa0pwol0006po8qkekhb7yz	1	clp8nhmzq0008po8hzjs7sb5u	t	clp8mkal10002po8huax3svf1	2023-11-22 17:09:34.415
clpa0s1fz002kq08rl7f9imen	clpa0pwol0006po8qkekhb7yz	2	clp8nklkx000cpo8h7k4km2ou	t	clp8mkal10002po8huax3svf1	2023-11-22 17:09:34.415
clpa2eu4z004mr18p6hbt2pkp	clpa2e549008qpu8qxz6pkw6h	10	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:55:17.652
clpa0mfwd0025r18psz70sxit	clpa0g196001nq08r2uca7f63	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:05:13.213
clpa0nf950005po8qrtb493ft	clpa0mh5l002kva8pn5efaz8t	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:05:59.034
clpa0nf950000po8q3v54r4a1	clpa0mh5l002kva8pn5efaz8t	2	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 17:05:59.034
clpa0nf950001po8q1db5j55e	clpa0mh5l002kva8pn5efaz8t	3	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:05:59.034
clpa0nf950002po8qxfrztjar	clpa0mh5l002kva8pn5efaz8t	3	clp9vaoeu000gpo8hc77dho1n	t	clp8mkal10002po8huax3svf1	2023-11-22 17:05:59.034
clpa0nf950003po8q11y0wuuz	clpa0mh5l002kva8pn5efaz8t	1	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 17:05:59.034
clpa0nf950004po8qcocpvgjp	clpa0mh5l002kva8pn5efaz8t	1	clp9v8lpf000dpo8hcroabax9	t	clp8mkal10002po8huax3svf1	2023-11-22 17:05:59.034
clpa0nk8o003xpu8qw2e8ooi7	clpa029n4000lpu8qyf8qpm4g	1	clp8nlysu000epo8hfkh22xyr	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:06:05.497
clpa0nlnj0048pu8que6bydhs	clpa0lo8a001von8qby4sz21b	1	clp8ngr850007po8h7tw98ftt	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:06:07.328
clpa0nul50022on8qpltydta8	clpa02qd90001po8qjnv48q89	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:06:18.906
clpa0rhu7004gpu8qf3kl5ws4	clpa0nh95002mva8pngzxzeag	1	clp8ngr850007po8h7tw98ftt	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:09:09.007
clpa2e3j00056va8pre581asw	clpa2ccy8003yva8pou67cav1	1	clp8nklkx000cpo8h7k4km2ou	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:54:43.165
clpa2kh5g0000po8qaugdswwj	clpa1rnx9004upu8qpt54b4wg	1	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:59:40.756
clpa2kh5g0001po8qkkqilqn8	clpa1rnx9004upu8qpt54b4wg	2	clp8nhmzq0008po8hzjs7sb5u	t	clp8mkal10002po8huax3svf1	2023-11-22 17:59:40.756
clpa2kh5g0002po8q0bctjiuq	clpa1rnx9004upu8qpt54b4wg	2	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 17:59:40.756
clpa2kh5g0003po8q4wx7rllu	clpa1rnx9004upu8qpt54b4wg	2	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 17:59:40.756
clpa2kh5g0004po8qjifzfm3v	clpa1rnx9004upu8qpt54b4wg	1	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:59:40.756
clpa2kh5g0005po8qbxcjw3lp	clpa1rnx9004upu8qpt54b4wg	1	clp9v8lpf000dpo8hcroabax9	t	clp8mkal10002po8huax3svf1	2023-11-22 17:59:40.756
clpa2kh5g0006po8qnpe59c98	clpa1rnx9004upu8qpt54b4wg	1	clp9v9po8000epo8he4i5uhsi	t	clp8mkal10002po8huax3svf1	2023-11-22 17:59:40.756
clpa0nk8o003wpu8qyjtbf54u	clpa029n4000lpu8qyf8qpm4g	1	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:06:05.497
clpa0nk8p003ypu8qq6v9u04e	clpa029n4000lpu8qyf8qpm4g	1	clp8nhmzq0008po8hzjs7sb5u	t	clp8mkal10002po8huax3svf1	2023-11-22 17:06:05.497
clpa0nk8p003zpu8qynm6o5yk	clpa029n4000lpu8qyf8qpm4g	1	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 17:06:05.497
clpa0nk8p0040pu8q724ade52	clpa029n4000lpu8qyf8qpm4g	1	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 17:06:05.497
clpa0nk8p0041pu8qa3j2vm5h	clpa029n4000lpu8qyf8qpm4g	1	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 17:06:05.497
clpa0nk8p0042pu8qdn38wfqv	clpa029n4000lpu8qyf8qpm4g	1	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 17:06:05.497
clpa0nk8p0043pu8qj100wv4o	clpa029n4000lpu8qyf8qpm4g	1	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:06:05.497
clpa0nk8p0044pu8q2rzd37qr	clpa029n4000lpu8qyf8qpm4g	1	clp8nik4o0009po8hsd476r6l	t	clp8mkal10002po8huax3svf1	2023-11-22 17:06:05.497
clpa0nk8p0045pu8qm323j1nk	clpa029n4000lpu8qyf8qpm4g	1	clp8nklkx000cpo8h7k4km2ou	t	clp8mkal10002po8huax3svf1	2023-11-22 17:06:05.497
clpa0nk8p0046pu8qiu0x3qze	clpa029n4000lpu8qyf8qpm4g	1	clp9v7rz7000cpo8hj4wekd3i	t	clp8mkal10002po8huax3svf1	2023-11-22 17:06:05.497
clpa0nlnj0047pu8qx53figv8	clpa0lo8a001von8qby4sz21b	10	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 17:06:07.328
clpa0nul5001won8qjrq91o70	clpa02qd90001po8qjnv48q89	2	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 17:06:18.905
clpa0nul5001xon8q0ws5xa1k	clpa02qd90001po8qjnv48q89	2	clp9v7rz7000cpo8hj4wekd3i	t	clp8mkal10002po8huax3svf1	2023-11-22 17:06:18.905
clpa0nul5001yon8qtjh8e63s	clpa02qd90001po8qjnv48q89	1	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 17:06:18.905
clpa0nul5001zon8q027l379t	clpa02qd90001po8qjnv48q89	2	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:06:18.905
clpa0nul50020on8qckg7bp5w	clpa02qd90001po8qjnv48q89	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8mkal10002po8huax3svf1	2023-11-22 17:06:18.905
clpa0nul50021on8q7oyybvno	clpa02qd90001po8qjnv48q89	2	clp8nhmzq0008po8hzjs7sb5u	t	clp8mkal10002po8huax3svf1	2023-11-22 17:06:18.905
clpa0qjxx002eq08rnrlnqjqa	clpa09pmc001wpu8qafj29y0g	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:08:25.078
clpa2kh5g0007po8qj103bz3z	clpa1rnx9004upu8qpt54b4wg	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:59:40.757
clpa0qjxx0027q08rtwi2ixcy	clpa09pmc001wpu8qafj29y0g	2	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 17:08:25.077
clpa0qjxx0028q08r5v5kzan8	clpa09pmc001wpu8qafj29y0g	1	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 17:08:25.077
clpa0qjxx0029q08rpo6xorb1	clpa09pmc001wpu8qafj29y0g	1	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:08:25.077
clpa0qjxx002aq08r2a84a3pd	clpa09pmc001wpu8qafj29y0g	3	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:08:25.077
clpa0qjxx002bq08rrfcmbwl0	clpa09pmc001wpu8qafj29y0g	1	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 17:08:25.077
clpa0qjxx002cq08rhxrc0uay	clpa09pmc001wpu8qafj29y0g	1	clp9v7rz7000cpo8hj4wekd3i	t	clp8mkal10002po8huax3svf1	2023-11-22 17:08:25.077
clpa0qjxx002dq08r1bx733bk	clpa09pmc001wpu8qafj29y0g	1	clp9v8lpf000dpo8hcroabax9	t	clp8mkal10002po8huax3svf1	2023-11-22 17:08:25.077
clpa02stx000fva8pglpgnprv	clpa01mwv0002q08rxtgei6sy	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:49:56.853
clpa039nt0013on8qq1yb2uoc	clpa00s7j000ion8qiw0j1iib	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:50:18.666
clpa03h7d000hr18p6cw9bbgi	clpa01o0j0007r18pip0c316p	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:50:28.441
clpa03hfx000jr18p35bfgp0g	clpa02ro2000fq08rd0zbt2ed	1	clp8nlysu000epo8hfkh22xyr	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:50:28.75
clpa03sap000rr18poav4i2ry	clpa00okz000cpu8qg0bxickx	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:50:42.818
clpa04agx000iq08r6jfbxl56	clpa00to50000r18p7w0y4n4f	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:51:06.369
clpa04yzz000zq08rnuri4vge	clpa01nri0006r18pfqadsrpv	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:51:38.159
clpa05lj40019pu8q3kdzudlw	clpa01ygj000jpu8qcxdxprj4	1	clp8nj655000apo8hwwssxkqr	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:52:07.361
clpa05mv7000mva8p1o1tqt0w	clpa035zv000tpu8q4mqdtjf4	1	clp8ngr850007po8h7tw98ftt	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:52:09.092
clpa079ps001ppu8qncvqo1xu	clpa03yui0014on8qer2lnf41	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:53:25.36
clpa07d8d0007po8qbc07b6v6	clpa01lxb0009va8pt21eejzu	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:53:29.918
clpa07i9b0008po8qeq5eiagc	clpa01e40000lon8qhxnthv1h	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:53:36.431
clpa083jp0015va8p8xqnyk7y	clpa062wi000nva8pfdrxhlb6	1	clp8nfqlb0005po8hvrohu5g7	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:54:04.022
clpa08dp7001dva8ps8vdkzr5	clpa05xas001bpu8qxgljvnf5	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:54:17.18
clpa08ekz001jva8p0bo03jxz	clpa05mvm001apu8qw98jfov8	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:54:18.324
clpa08oc5001hon8qtq9fujkk	clp8npp76000fpo8h8i8cf5sz	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:54:30.966
clpa08ptv001vpu8q9w9y83dg	clpa07dtr001qpu8qzf6gyw3o	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:54:32.899
clpa092b8001nva8pla5wc79y	clpa07bgk0012q08r4hz0xrxm	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:54:49.077
clpa09kq8000ipo8qjz510ag7	clpa08fz40013q08rxe1oo02u	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:55:12.944
clpa0bl7e000qpo8q9uandfys	clpa02d83000npu8qn5j6y94f	1	clp8ngr850007po8h7tw98ftt	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:56:46.875
clpa0bmrc001fq08rsb63t0d7	clpa00nt90002va8pa1iotpq6	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:56:48.889
clpa0bn3p001lq08rsfizhyzl	clpa091ot001kon8q3ia0d6ot	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:56:49.334
clpa0bs7h0014po8q1fosb1lp	clpa02w1l000uon8qc1c6jqv9	1	clp8ngr850007po8h7tw98ftt	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:56:55.95
clpa0c8up002hpu8qw4cg5z6l	clpa01zqv000mon8q9nbcqysb	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:57:17.522
clpa0clyb002qpu8q65g785cd	clpa0c2z4001pr18pkaftww7i	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:57:34.499
clpa0co87002vpu8qm9m32xgu	clpa0a7rg000opo8q8gt0e1h0	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:57:37.447
clpa0fmin003apu8qh7x7w0b1	clpa0c0ap0015po8qy56ztfi3	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 16:59:55.2
clpa0gb9c001vq08rfiyuirqn	clpa03rg7000upu8qdh8dpyo1	1	clp8ngr850007po8h7tw98ftt	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:00:27.264
clpa0hcbd001yq08rrvijnh6w	clpa02de6000eq08rnw7q1tz4	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:01:15.289
clpa0hn36002jva8px4w58zv7	clpa08zq9001ion8qb39zwl64	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:01:29.25
clpa0j2ty001ur18pubm98fco	clpa0gqmr002ava8pyx5n2vi1	1	clp8ngr850007po8h7tw98ftt	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:02:36.31
clpa0j3ha001vr18pjalh64ia	clpa0du8o001mq08raus3uucs	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:02:37.15
clpa0jpmj003ppu8qvglmqro6	clpa0db480020va8pssnhknlj	1	clp9v9po8000epo8he4i5uhsi	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:03:05.851
clpa0lcef003qpu8q7u3bbgkz	clpa0ekez0022va8pmq3kaigy	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:04:22.024
clpa0lttu0023q08rllqlodwu	clpa0l7jl0022q08rrreztqoe	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:04:44.611
clpa0s1fz002lq08rsqxaw2ps	clpa0pwol0006po8qkekhb7yz	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:09:34.416
clpa0xyes004mpu8qf2qq175n	clpa0tapw002mq08rlmutqh0g	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:14:10.421
clpa0y5b4002sq08rkldknh25	clpa0w2f10026r18punynbagj	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:14:19.36
clpa0ycy0002tva8p56c3m4ui	clpa0scbl0008po8qy37jmav4	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:14:29.256
clpa0zlq70004po8q20d2o7oc	clpa0xeub0023on8qhui1ja4f	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:15:27.295
clpa10e4v002tq08rcsh32nb8	clpa0z8y80028r18p8ce34l69	1	clp8ngr850007po8h7tw98ftt	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:16:04.111
clpa12opx002vva8p8qr6955m	clpa118o7002yq08rvqp1ukij	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:17:51.142
clpa14wu9002ar18ppz9n0oja	clpa0p0ds0025q08r62i7l70z	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:19:34.978
clpa17e0r002hr18pyzz38lko	clpa165ne002br18pac1d3bzj	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:21:30.556
clpa17fj6004qpu8q9s6hbo94	clpa02390000cq08rurrbh3oo	1	clp8ngr850007po8h7tw98ftt	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:21:32.514
clpa19zqa002bon8q7z4lc5zf	clpa1992w002ir18pggihja2o	1	clp8ngr850007po8h7tw98ftt	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:23:32.003
clpa1aj7b0030q08rze0ccr2r	clpa17k830027on8qzaet9vq3	1	clp8nlysu000epo8hfkh22xyr	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:23:57.239
clpa1dsee0000po8qtc4p0i82	clpa1bg330031q08rodho385b	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:26:29.127
clpa1h1bn002ion8qdrnkna5i	clpa1doph004rpu8qc80rksir	1	clp8nldjl000dpo8hh9hks0t2	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:29:00.66
clpa0rhu7004bpu8qjn9breaw	clpa0nh95002mva8pngzxzeag	1	clp8nhmzq0008po8hzjs7sb5u	t	clp8mkal10002po8huax3svf1	2023-11-22 17:09:09.007
clpa0xyes004jpu8qa7hvasje	clpa0tapw002mq08rlmutqh0g	3	clp8ng6zm0006po8hcbqwqbjm	t	clp8mkal10002po8huax3svf1	2023-11-22 17:14:10.421
clpa0xyes004kpu8qg2vn15cc	clpa0tapw002mq08rlmutqh0g	4	clp8nhmzq0008po8hzjs7sb5u	t	clp8mkal10002po8huax3svf1	2023-11-22 17:14:10.421
clpa0xyes004lpu8q6eeh5tg5	clpa0tapw002mq08rlmutqh0g	3	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 17:14:10.421
clpa0y5b3002oq08rs603scoe	clpa0w2f10026r18punynbagj	7	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 17:14:19.36
clpa0y5b3002pq08r9bps33xo	clpa0w2f10026r18punynbagj	1	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 17:14:19.36
clpa0y5b3002qq08rnepbb57z	clpa0w2f10026r18punynbagj	1	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 17:14:19.36
clpa0y5b3002rq08r02z9na63	clpa0w2f10026r18punynbagj	1	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:14:19.36
clpa0ycxz002ova8pf47mtzel	clpa0scbl0008po8qy37jmav4	3	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 17:14:29.256
clpa0ycxz002pva8p50wc3imh	clpa0scbl0008po8qy37jmav4	3	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 17:14:29.256
clpa0ycxz002qva8puy43aqa3	clpa0scbl0008po8qy37jmav4	1	clp8nhmzq0008po8hzjs7sb5u	t	clp8mkal10002po8huax3svf1	2023-11-22 17:14:29.256
clpa0ycxz002rva8povzm5aib	clpa0scbl0008po8qy37jmav4	2	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:14:29.256
clpa0ycxz002sva8p7b89dcge	clpa0scbl0008po8qy37jmav4	1	clp9v8lpf000dpo8hcroabax9	t	clp8mkal10002po8huax3svf1	2023-11-22 17:14:29.256
clpa0zlq70000po8q4ir8xjga	clpa0xeub0023on8qhui1ja4f	5	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 17:15:27.295
clpa0zlq70001po8q8vo6akpi	clpa0xeub0023on8qhui1ja4f	1	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 17:15:27.295
clpa1qv6j002ron8qk9ir6zr1	clpa1f3c0002yva8p9vwh0n0b	1	clp8ngr850007po8h7tw98ftt	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:36:39.26
clpa1sjor002nr18pwpmoup1z	clpa1mv29003bva8pq3i4l7vs	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:37:57.675
clpa1sqc4002son8qmiheyibl	clp8t043k0004po8hwv0zmkbb	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:38:06.293
clpa1tud50050pu8qz4y1lsyk	clpa1i7f1002jon8qf29xnxdc	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:38:58.169
clpa1vuzd0004po8qxocftlqw	clpa1txsa003iva8p03v79bh5	1	clp8ngr850007po8h7tw98ftt	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:40:32.282
clpa1x3yf0005po8qnsdc7b4t	clpa1q6n6002jr18pm5p6g9aw	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:41:30.567
clpa1y3900051pu8qoyatvhnl	clpa1vk6q002won8q60cjpj78	1	clp8ngr850007po8h7tw98ftt	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:42:16.308
clpa1h1bn002eon8q7ervcsy9	clpa1doph004rpu8qc80rksir	3	clp8ng6zm0006po8hcbqwqbjm	t	clp8mkal10002po8huax3svf1	2023-11-22 17:29:00.659
clpa1h1bn002fon8qzbghb3cl	clpa1doph004rpu8qc80rksir	2	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 17:29:00.659
clpa1h1bn002gon8qe2yvlrtb	clpa1doph004rpu8qc80rksir	2	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:29:00.659
clpa1h1bn002hon8qecfxr5px	clpa1doph004rpu8qc80rksir	3	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 17:29:00.659
clpa1ne9j003dva8pgg83kb5i	clpa1mkpb004tpu8qhgdexz61	1	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 17:33:57.368
clpa1ne9j003eva8pjklbjsjb	clpa1mkpb004tpu8qhgdexz61	1	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 17:33:57.368
clpa1ne9j003fva8pis44ekn3	clpa1mkpb004tpu8qhgdexz61	1	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 17:33:57.368
clpa1ne9j003gva8pjn39gyxh	clpa1mkpb004tpu8qhgdexz61	1	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:33:57.368
clpa1hpk6002zva8p2yi9tz9g	clpa0f2580034pu8qpceu7m3g	6	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 17:29:32.071
clpa1hpk60030va8p1wuudwo0	clpa0f2580034pu8qpceu7m3g	1	clp9v7rz7000cpo8hj4wekd3i	t	clp8mkal10002po8huax3svf1	2023-11-22 17:29:32.071
clpa1hpk60031va8p24fgk1r0	clpa0f2580034pu8qpceu7m3g	3	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:29:32.071
clpa1hpk70032va8pfflacy86	clpa0f2580034pu8qpceu7m3g	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:29:32.071
clpa1ms730038va8pet1uw1qn	clpa1jj62003aq08rn18cee9j	7	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 17:33:28.767
clpa1ms730039va8pxyzxyrwr	clpa1jj62003aq08rn18cee9j	3	clp9v7rz7000cpo8hj4wekd3i	t	clp8mkal10002po8huax3svf1	2023-11-22 17:33:28.767
clpa1i77z0033va8pn386t8qv	clpa1fpkj0008po8qhwtl6w7o	5	clp8nhmzq0008po8hzjs7sb5u	t	clp8mkal10002po8huax3svf1	2023-11-22 17:29:54.96
clpa1i77z0034va8ptdxhqhe6	clpa1fpkj0008po8qhwtl6w7o	3	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 17:29:54.96
clpa1i77z0035va8pfnxm7nh7	clpa1fpkj0008po8qhwtl6w7o	1	clp9v9po8000epo8he4i5uhsi	t	clp8mkal10002po8huax3svf1	2023-11-22 17:29:54.96
clpa1i7800036va8p3bimpauk	clpa1fpkj0008po8qhwtl6w7o	1	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:29:54.96
clpa1i7800037va8pcxa5elzj	clpa1fpkj0008po8qhwtl6w7o	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:29:54.96
clpa1ms73003ava8pw1kwck6h	clpa1jj62003aq08rn18cee9j	1	clp8nfqlb0005po8hvrohu5g7	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:33:28.767
clpa1ne9k003hva8p79bv6m7r	clpa1mkpb004tpu8qhgdexz61	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:33:57.368
clpa1qv6j002lon8qtavnowux	clpa1f3c0002yva8p9vwh0n0b	1	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 17:36:39.259
clpa1qv6j002mon8q5nquki1l	clpa1f3c0002yva8p9vwh0n0b	1	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:36:39.259
clpa1qv6j002non8qyt4dhpor	clpa1f3c0002yva8p9vwh0n0b	1	clp8nik4o0009po8hsd476r6l	t	clp8mkal10002po8huax3svf1	2023-11-22 17:36:39.259
clpa1qv6j002oon8qfh8teq5o	clpa1f3c0002yva8p9vwh0n0b	1	clp8nklkx000cpo8h7k4km2ou	t	clp8mkal10002po8huax3svf1	2023-11-22 17:36:39.259
clpa1qv6j002pon8q9qs06acp	clpa1f3c0002yva8p9vwh0n0b	1	clp8njq3w000bpo8hzara7tmw	t	clp8mkal10002po8huax3svf1	2023-11-22 17:36:39.259
clpa1qv6j002qon8qhcjerukz	clpa1f3c0002yva8p9vwh0n0b	1	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 17:36:39.259
clpa22bjt0034on8qpe2r565h	clpa0s3se004hpu8q67a52qbu	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:45:33.689
clpa240u1003cq08re5okep98	clpa22b3e0000po8q0v8hkwcs	1	clp8nhmzq0008po8hzjs7sb5u	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:46:53.114
clpa246z7003jq08r9659opfj	clpa221ad005bpu8q2dsqbndr	1	clp8nlysu000epo8hfkh22xyr	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:47:01.076
clpa240u0003bq08rcw1odp1j	clpa22b3e0000po8q0v8hkwcs	10	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:46:53.113
clpa246z7003dq08rmxwz3gem	clpa221ad005bpu8q2dsqbndr	2	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 17:47:01.075
clpa246z7003eq08ros69unll	clpa221ad005bpu8q2dsqbndr	3	clp8nj655000apo8hwwssxkqr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:47:01.075
clpa246z7003fq08rsq6hwszi	clpa221ad005bpu8q2dsqbndr	2	clp8nklkx000cpo8h7k4km2ou	t	clp8mkal10002po8huax3svf1	2023-11-22 17:47:01.075
clpa246z7003gq08rjgjl5bv6	clpa221ad005bpu8q2dsqbndr	1	clp9v7rz7000cpo8hj4wekd3i	t	clp8mkal10002po8huax3svf1	2023-11-22 17:47:01.075
clpa246z7003hq08ro90fd95d	clpa221ad005bpu8q2dsqbndr	1	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:47:01.075
clpa246z7003iq08rhuy1tucm	clpa221ad005bpu8q2dsqbndr	1	clp9v9po8000epo8he4i5uhsi	t	clp8mkal10002po8huax3svf1	2023-11-22 17:47:01.075
clpa282h30037on8qe1sfo0ve	clpa27vdn003mva8px7hevy3h	10	clp8nklkx000cpo8h7k4km2ou	t	clp8mkal10002po8huax3svf1	2023-11-22 17:50:01.863
clpa282h30038on8qy373qdyb	clpa27vdn003mva8px7hevy3h	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:50:01.864
clpa28qr50002po8pqn0zxu9w	clpa26rg8005dpu8qrnjtd6qm	1	clp8ng6zm0006po8hcbqwqbjm	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:50:33.33
clpa28qr60003po8pq6iuxvk9	clpa26rg8005dpu8qrnjtd6qm	4	clp9v7rz7000cpo8hj4wekd3i	t	clp8mkal10002po8huax3svf1	2023-11-22 17:50:33.33
clpa28qr60004po8pwkdzovtv	clpa26rg8005dpu8qrnjtd6qm	4	clp8nfqlb0005po8hvrohu5g7	t	clp8mkal10002po8huax3svf1	2023-11-22 17:50:33.33
clpa28qr60005po8pqwmr68e9	clpa26rg8005dpu8qrnjtd6qm	1	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 17:50:33.33
clpa28qr60006po8pm3uow51w	clpa26rg8005dpu8qrnjtd6qm	1	clp8nldjl000dpo8hh9hks0t2	t	clp8mkal10002po8huax3svf1	2023-11-22 17:50:33.33
clpa2bfee003xva8p67l7ezd3	clpa28ni20000po8px4ssrg8i	1	clp8mq9mz0004po8h2r00xlaj	t	clp8movr40003po8hk44ct7ez	2023-11-22 17:52:38.582
clpa2bfed003tva8p3lpz7ie8	clpa28ni20000po8px4ssrg8i	2	clp8ngr850007po8h7tw98ftt	t	clp8mkal10002po8huax3svf1	2023-11-22 17:52:38.582
clpa2bfed003uva8phqx9s533	clpa28ni20000po8px4ssrg8i	2	clp9vaoeu000gpo8hc77dho1n	t	clp8mkal10002po8huax3svf1	2023-11-22 17:52:38.582
clpa2bfed003vva8pzxsyc16v	clpa28ni20000po8px4ssrg8i	4	clp8mq9mz0004po8h2r00xlaj	t	clp8mkal10002po8huax3svf1	2023-11-22 17:52:38.582
clpa2bfed003wva8p0389dd6a	clpa28ni20000po8px4ssrg8i	2	clp8nlysu000epo8hfkh22xyr	t	clp8mkal10002po8huax3svf1	2023-11-22 17:52:38.582
\.


--
-- Data for Name: _prisma_migrations; Type: TABLE DATA; Schema: public; Owner: hackathon_command_centre
--

COPY public._prisma_migrations (id, checksum, finished_at, migration_name, logs, rolled_back_at, started_at, applied_steps_count) FROM stdin;
cf869987-cc43-4572-b63c-c9065eb0ed16	77281d8bc766d6382b4e1824485748a244ca98f5b8412e06a06adde89e3095d5	2023-11-21 17:09:58.620163+00	20230323014808_initial_db	\N	\N	2023-11-21 17:09:58.609625+00	1
5fd4b55f-a88c-4488-beed-e22cbea43b94	3c0bf85d3576a5b58d39412c6041aa2a05540fa728ad3e702ecda95fc7090b0a	2023-11-21 17:09:58.738228+00	20231119234926_use_unique_email_instead_of_fullname	\N	\N	2023-11-21 17:09:58.733681+00	1
7be63e5c-835f-4064-939d-185a66cad6f9	b54b0bd1959d9f32e04977c1a68c22a14e9a3234634a8d479201a937c7c5b0e2	2023-11-21 17:09:58.627972+00	20230323015253_models_to_pascal_case	\N	\N	2023-11-21 17:09:58.622442+00	1
067f8846-43d1-48be-8638-b9e87b7d31dd	1e4090ad82a8a777825143789ca3c42ccd292befc63e2d765f1cf64f8e66e3a3	2023-11-21 17:09:58.6416+00	20231118185135_add_initial_voting_entities	\N	\N	2023-11-21 17:09:58.630028+00	1
272160c9-0332-499a-9e60-375ae71c1baf	372ef1878ba98f250ddd84776fc1b6d96d1fd5b6984cb7ba123c4d7ab1943294	2023-11-22 02:09:13.682353+00	20231122014525_singular_admin_control_table_name	\N	\N	2023-11-22 02:09:13.676172+00	1
24866b82-d22d-429a-86fc-047975d0e0ef	b3d1536b99be57250f0771327b91d4dfc734adaded77c46fd00ce5a03d63f46f	2023-11-21 17:09:58.666239+00	20231118212349_rename_entry_to_hack	\N	\N	2023-11-21 17:09:58.648346+00	1
f6a1e24e-d730-45f3-821d-c7ff284f82f3	7be882296b5cec2cd9459bfe59cb2f8ced41b4125e4fb21b231ba4dee321c823	2023-11-21 17:09:58.743937+00	20231120022340_add_description_to_prize	\N	\N	2023-11-21 17:09:58.739924+00	1
495fed8a-7855-4e09-8126-236a2d807444	2f8d847d0005af00801b461b530f7aea8b566fb82400422564d101115fd98689	2023-11-21 17:09:58.674848+00	20231119150830_add_num_votes_to_vote	\N	\N	2023-11-21 17:09:58.670038+00	1
69e77377-3f87-4ac3-9e3c-9c63b1380798	af5d8276dc3f37be20d9da612f3c9f6ee0a0add42cecdc7c7ca5ac68ec7b436c	2023-11-21 17:09:58.685125+00	20231119151330_add_user_owned_hacks_table	\N	\N	2023-11-21 17:09:58.676672+00	1
db63c3b7-f75b-4b7b-b857-3290b9403d2c	eeade8e1825c45c430aa01f025650dc87c761e3a18c35e741e615c1863e6b51a	2023-11-21 17:09:58.692098+00	20231119151431_rename_entry_to_hack	\N	\N	2023-11-21 17:09:58.686925+00	1
57f509cc-824d-46f6-a50b-20c4c2866038	ec9b4ca0a959eab671dcb3d4927e80822c9a2851401683ff692168bba1f1c690	2023-11-21 17:09:58.751447+00	20231120030547_make_prize_required_for_votes	\N	\N	2023-11-21 17:09:58.745499+00	1
a3285221-a995-4baa-9743-71826695af3a	ec74334ec1ea60100ea86ad822a2502e12e3df0774d66fd5a04f36a7db1b07f5	2023-11-21 17:09:58.697165+00	20231119152543_make_user_name_required	\N	\N	2023-11-21 17:09:58.693573+00	1
17549798-ac33-4327-9420-5fdc29f5f7bc	47590f1e2d45fc553568451d0106265c296fdc40b851e7e5149eb1602ac28bb5	2023-11-21 17:09:58.704706+00	20231119154257_add_admin_user_lookup	\N	\N	2023-11-21 17:09:58.698481+00	1
90ba31a7-51fc-4233-bbe5-70abcad20585	c96e05e2ee59fdac966106b71c5f76e49e1077d3f1eee6d446fb0c92af586b57	2023-11-21 17:09:58.711157+00	20231119154455_make_admin_user_id_unique	\N	\N	2023-11-21 17:09:58.706207+00	1
35ee5438-1947-466e-bb0b-a79240d77c56	2a2d066850e5571776e29482d05aa848000f3ef2149d38a3f8301ffe7439f1ae	2023-11-21 17:09:58.758492+00	20231120045525_add_prize_id_to_vote_unique_constraint	\N	\N	2023-11-21 17:09:58.753254+00	1
ed5e22eb-9ad8-43b7-bcff-a02dcf52a730	766c1aac4cf989435b688235cd445a365c87cd554d2a85db1ed419f608e795a5	2023-11-21 17:09:58.716702+00	20231119160208_remove_uuid_for_admin	\N	\N	2023-11-21 17:09:58.712588+00	1
bff37dde-fdaf-41c9-9576-f03dc0074738	f63f3dc8f2ba7e2cb98509b6466553c63a2e5e451092e32fb2ca2045a0e849c2	2023-11-21 17:09:58.722779+00	20231119164503_	\N	\N	2023-11-21 17:09:58.718358+00	1
446f0f27-0f76-4b3f-90bc-472c395f26a3	f76ca3a6d28a8cd6484dc04508cc632b03f6af323a4f073c9ce5801451fdf876	2023-11-22 06:07:30.047193+00	20231122044730_break_out_group_activity_into_other_activities	\N	\N	2023-11-22 06:07:30.032388+00	1
17031b0e-8f96-4409-8109-f5c49f1f1736	a446a3f1731032ebbf13746db8449a7dec965ecbb68d918f1efa80b0b417b16f	2023-11-21 17:09:58.731822+00	20231119234629_add_prize_field_and_type	\N	\N	2023-11-21 17:09:58.724336+00	1
044a7661-8653-49ea-a60b-be7d324aa2e4	8f53766c20a63f0d883199cdeee0281418d45b9f4bb9c6655569bf38cec18dab	2023-11-21 17:09:58.764288+00	20231121022742_add_prize_config_options	\N	\N	2023-11-21 17:09:58.760139+00	1
f53a7726-b67d-4115-aa03-716d6ee28d77	fbba78c3a2541fc667ca523bebb1947e9131f92bc0f046de0ea0fa30bc8e446d	2023-11-21 17:09:58.770623+00	20231121025332_add_cascade_delete_to_prize	\N	\N	2023-11-21 17:09:58.766191+00	1
2961608c-34da-48ae-8f46-00c0e14bd4be	16e96fc0296212de0dc6e16d1860f240c38d10858d19aa644c9a56fc678b8a5f	2023-11-21 17:09:58.776552+00	20231121042216_add_image_urls_to_prizes_and_entries	\N	\N	2023-11-21 17:09:58.772273+00	1
819f03a9-dbc4-4bf7-9e9f-6b34656db3a4	7461761fd5107ce2ada856aa00ab2bff4693f456b372f243c219f55164738084	2023-11-22 06:07:30.05644+00	20231122053119_rename_to_voting_enabled	\N	\N	2023-11-22 06:07:30.049711+00	1
fe836cf7-48df-4bad-8e98-7ab59cee6685	37e7084128942f2dc0e8c7d2fc1a1a82233c0d319e8dce99bdfc07284a89606f	2023-11-22 02:09:13.673909+00	20231122014412_add_vote_timestamp_admin_controls	\N	\N	2023-11-22 02:09:13.653749+00	1
dfeacd81-6494-4bf8-8a87-3718fb6d09e5	0faf9458e7cdf28cbf4c576fb9a4a88e08bff40929168bfd50cee753a73f6df4	2024-01-02 14:45:11.962673+00	20231222170934_rename_admin_control_to_app_control	\N	\N	2024-01-02 14:45:11.906128+00	1
\.


--
-- Name: AppControl AppControl_pkey; Type: CONSTRAINT; Schema: public; Owner: hackathon_command_centre
--

ALTER TABLE ONLY public."AppControl"
    ADD CONSTRAINT "AppControl_pkey" PRIMARY KEY (id);


--
-- Name: Entry Entry_pkey; Type: CONSTRAINT; Schema: public; Owner: hackathon_command_centre
--

ALTER TABLE ONLY public."Entry"
    ADD CONSTRAINT "Entry_pkey" PRIMARY KEY (id);


--
-- Name: Prize Prize_pkey; Type: CONSTRAINT; Schema: public; Owner: hackathon_command_centre
--

ALTER TABLE ONLY public."Prize"
    ADD CONSTRAINT "Prize_pkey" PRIMARY KEY (id);


--
-- Name: UserEntries UserEntries_pkey; Type: CONSTRAINT; Schema: public; Owner: hackathon_command_centre
--

ALTER TABLE ONLY public."UserEntries"
    ADD CONSTRAINT "UserEntries_pkey" PRIMARY KEY (id);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: hackathon_command_centre
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: Vote Vote_pkey; Type: CONSTRAINT; Schema: public; Owner: hackathon_command_centre
--

ALTER TABLE ONLY public."Vote"
    ADD CONSTRAINT "Vote_pkey" PRIMARY KEY (id);


--
-- Name: _prisma_migrations _prisma_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: hackathon_command_centre
--

ALTER TABLE ONLY public._prisma_migrations
    ADD CONSTRAINT _prisma_migrations_pkey PRIMARY KEY (id);


--
-- Name: AdminUser_user_key; Type: INDEX; Schema: public; Owner: hackathon_command_centre
--

CREATE UNIQUE INDEX "AdminUser_user_key" ON public."AdminUser" USING btree ("user");


--
-- Name: User_email_key; Type: INDEX; Schema: public; Owner: hackathon_command_centre
--

CREATE UNIQUE INDEX "User_email_key" ON public."User" USING btree (email);


--
-- Name: Vote_user_entry_prize_key; Type: INDEX; Schema: public; Owner: hackathon_command_centre
--

CREATE UNIQUE INDEX "Vote_user_entry_prize_key" ON public."Vote" USING btree ("user", entry, prize);


--
-- Name: AdminUser AdminUser_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hackathon_command_centre
--

ALTER TABLE ONLY public."AdminUser"
    ADD CONSTRAINT "AdminUser_user_fkey" FOREIGN KEY ("user") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserEntries UserEntries_entry_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hackathon_command_centre
--

ALTER TABLE ONLY public."UserEntries"
    ADD CONSTRAINT "UserEntries_entry_fkey" FOREIGN KEY (entry) REFERENCES public."Entry"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: UserEntries UserEntries_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hackathon_command_centre
--

ALTER TABLE ONLY public."UserEntries"
    ADD CONSTRAINT "UserEntries_user_fkey" FOREIGN KEY ("user") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Vote Vote_entry_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hackathon_command_centre
--

ALTER TABLE ONLY public."Vote"
    ADD CONSTRAINT "Vote_entry_fkey" FOREIGN KEY (entry) REFERENCES public."Entry"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Vote Vote_prize_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hackathon_command_centre
--

ALTER TABLE ONLY public."Vote"
    ADD CONSTRAINT "Vote_prize_fkey" FOREIGN KEY (prize) REFERENCES public."Prize"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Vote Vote_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: hackathon_command_centre
--

ALTER TABLE ONLY public."Vote"
    ADD CONSTRAINT "Vote_user_fkey" FOREIGN KEY ("user") REFERENCES public."User"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

