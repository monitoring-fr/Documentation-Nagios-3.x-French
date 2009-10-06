XMLSOURCE=About/fr_FR.about.xml About/fr_FR.whatsnew.xml About/fr_FR.knownissues.xml fr_FR.About.xml AdvancedTopics/fr_FR.adaptive.xml AdvancedTopics/fr_FR.cachedchecks.xml AdvancedTopics/fr_FR.cgiincludes.xml AdvancedTopics/fr_FR.checkscheduling.xml AdvancedTopics/fr_FR.clusters.xml AdvancedTopics/fr_FR.dependencies.xml AdvancedTopics/fr_FR.dependencychecks.xml AdvancedTopics/fr_FR.distributed.xml AdvancedTopics/fr_FR.downtime.xml AdvancedTopics/fr_FR.embeddedperl.xml AdvancedTopics/fr_FR.escalations.xml AdvancedTopics/fr_FR.eventhandlers.xml AdvancedTopics/fr_FR.extcommands.xml AdvancedTopics/fr_FR.flapping.xml AdvancedTopics/fr_FR.freshness.xml AdvancedTopics/fr_FR.objectinheritance.xml AdvancedTopics/fr_FR.objecttricks.xml AdvancedTopics/fr_FR.oncallrotation.xml AdvancedTopics/fr_FR.passivestatetranslation.xml AdvancedTopics/fr_FR.perfdata.xml AdvancedTopics/fr_FR.redundancy.xml AdvancedTopics/fr_FR.stalking.xml AdvancedTopics/fr_FR.volatileservices.xml fr_FR.AdvancedTopics.xml ConfiguringNagios/fr_FR.cgiauth.xml ConfiguringNagios/fr_FR.config.xml ConfiguringNagios/fr_FR.configcgi.xml ConfiguringNagios/fr_FR.configmain.xml ConfiguringNagios/fr_FR.configobject.xml ConfiguringNagios/fr_FR.customobjectvars.xml ConfiguringNagios/fr_FR.objectdefinitions.xml fr_FR.ConfiguringNagios.xml Development/fr_FR.epnplugins.xml Development/fr_FR.pluginapi.xml fr_FR.Development.xml GettingStarted/fr_FR.beginners.xml GettingStarted/fr_FR.monitoring-linux.xml GettingStarted/fr_FR.monitoring-netware.xml GettingStarted/fr_FR.monitoring-printers.xml GettingStarted/fr_FR.monitoring-publicservices.xml GettingStarted/fr_FR.monitoring-routers.xml GettingStarted/fr_FR.monitoring-windows.xml GettingStarted/fr_FR.quickstart-fedora.xml GettingStarted/fr_FR.quickstart-opensuse.xml GettingStarted/fr_FR.quickstart-ubuntu.xml GettingStarted/fr_FR.quickstart.xml GettingStarted/fr_FR.upgrading.xml fr_FR.GettingStarted.xml IntegrationWithOtherSoftware/fr_FR.int-snmptrap.xml IntegrationWithOtherSoftware/fr_FR.int-tcpwrappers.xml IntegrationWithOtherSoftware/fr_FR.integration.xml fr_FR.IntegrationWithOtherSoftware.xml NagiosAddons/fr_FR.addons.xml fr_FR.NagiosAddons.xml RunningNagios/fr_FR.startstop.xml RunningNagios/fr_FR.verifyconfig.xml fr_FR.RunningNagios.xml SecurityAndPerformanceTuning/fr_FR.cgisecurity.xml SecurityAndPerformanceTuning/fr_FR.faststartup.xml SecurityAndPerformanceTuning/fr_FR.largeinstalltweaks.xml SecurityAndPerformanceTuning/fr_FR.mrtggraphs.xml SecurityAndPerformanceTuning/fr_FR.nagiostats.xml SecurityAndPerformanceTuning/fr_FR.security.xml SecurityAndPerformanceTuning/fr_FR.tuning.xml fr_FR.SecurityAndPerformanceTuning.xml TheBasics/fr_FR.activechecks.xml TheBasics/fr_FR.cgis.xml TheBasics/fr_FR.hostchecks.xml TheBasics/fr_FR.macrolist.xml TheBasics/fr_FR.macros.xml TheBasics/fr_FR.networkreachability.xml TheBasics/fr_FR.notifications.xml TheBasics/fr_FR.passivechecks.xml TheBasics/fr_FR.plugins.xml TheBasics/fr_FR.servicechecks.xml TheBasics/fr_FR.statetypes.xml TheBasics/fr_FR.timeperiods.xml fr_FR.TheBasics.xml fr_FR.nagios.xml

all:html/index.html pdf/fr_FR.nagios-dblatex.pdf pdf/fr_FR.nagios-db2latex.pdf pdf/fr_FR.nagios-fop.pdf dvi/fr_FR.nagios.dvi

html/index.html:$(XMLSOURCE)
	xmlto -o html/ html fr_FR.nagios.xml	
	
pdf/nagios-dblatex.pdf:$(XMLSOURCE)
	dblatex fr_FR.nagios.xml -o pdf/fr_FR.nagios-dblatex.pdf

pdf/nagios-db2latex.pdf:$(XMLSOURCE)
	dblatex fr_FR.nagios.xml -o pdf/fr_FR.nagios-db2latex.pdf -T db2latex

pdf/nagios-fop.pdf:$(XMLSOURCE)
	xmlto -o pdf --with-fop pdf fr_FR.nagios.xml
	mv pdf/fr_FR.nagios.pdf pdf/fr_FR.nagios-fop.pdf

dvi/nagios.dvi:$(XMLSOURCE)
	xmllint --xinclude --postvalid  fr_FR.nagios.xml --output fr_FR.nagios-big.xml
	docbook2dvi -o dvi fr_FR.nagios-big.xml
	mv dvi/fr_FR.nagios-big.dvi dvi/fr_FR.nagios.dvi
	rm fr_FR.nagios-big.xml

clean:
	rm -f pdf/fr_FR.nagios-dblatex.pdf pdf/fr_FR.nagios-db2latex.pdf pdf/fr_FR.nagios-fop.pdf fr_FR.nagios-big.xml dvi/fr_FR.nagios.dvi html/*.html
