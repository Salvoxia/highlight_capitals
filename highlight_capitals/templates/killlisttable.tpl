<!-- killlistable.tpl -->
{if function_exists('getCynoList') && config::get('cc_cyno')}
	{$cynos = call_user_func('getCynoList')}
{/if}
{if function_exists('getCloakList') && config::get('cc_cloak')}
	{$cloaks = call_user_func('getCloakList')}
{/if}

<div class="kltable">
	{section name=day loop=$killlist}
		{if $daybreak}
			<div class="kb-date-header">{"l, F jS"|date:$killlist[day].date}</div><br />
			{if isset($show_summary) && $show_summary}
				<table class="kb-table kb-kl-table">
					<tr class="kb-kl-table-summary">
						{if $killlist[day].summary.numberOfKills > 0 || isset($killlist[day].summary.efficiency)}<td class="killcount">Kills: {$killlist[day].summary.numberOfKills}</td>{/if}
						{if $killlist[day].summary.numberOfLosses > 0 || isset($killlist[day].summary.efficiency)}<td class="{if $killlist[day].summary.numberOfKills > 0 || isset($killlist[day].summary.efficiency)}kb-kl-summary-cell{/if} losscount">Losses: {$killlist[day].summary.numberOfLosses}</td>{/if}
						{if isset($killlist[day].summary.efficiency)}<td class="kb-kl-summary-cell efficiency">Efficiency: {$killlist[day].summary.efficiency}%</td>{/if}
					</tr>
				</table>
			{/if}
		{/if}
		<table class="kb-table kb-kl-table kb-table-rows">
			<thead>
				<tr class="kb-table-header">
					<td class="kl-shiptype" colspan="{if isset($cynos) || isset($cloaks) || isset($entosises)}3{else}2{/if}">Ship type</td>
					<td colspan="2" class="kl-victim">Victim</td>
					<td class="kl-finalblow">Final blow</td>
					<td class="kl-location">Location</td>
				</tr>
			</thead>
			<tbody>
				{section name=kill loop=$killlist[day].kills}
					{assign var="k" value=$killlist[day].kills[kill]}
					
					{if $k.loss}
						<tr class="kb-table-row-loss {$k.highlight}" onclick="window.location.href='{$k.urldetail}';">
						{elseif $k.kill}
						<tr class="kb-table-row-kill {$k.highlight}" onclick="window.location.href='{$k.urldetail}';">
						{else}
						<tr class="{$k.highlight}" onclick="window.location.href='{$k.urldetail}';">
						{/if}
						<td class="kb-table-imgcell">
							<img src='{$k.victimshipimage}' style="width: 32px; height: 32px;" alt="" />
						</td>
						{if isset($cynos) || isset($cloaks)}
							<td class="kl-cyno-cloak-mod{if isset($cloaks)} cloak{/if}{if isset($cynos)} cyno{/if}">
								{if isset($cloaks)}
									<img src=http://image.eveonline.com/InventoryType/11370_32.png {if in_array({$k.id}, $cloaks)}style="opacity:1;"{/if} alt="" />
								{/if}
								{if isset($cynos)}
									<img src=http://image.eveonline.com/InventoryType/21096_32.png {if in_array({$k.id}, $cynos)}style="opacity:1;"{/if} alt="" />
								{/if}
							</td>
						{/if}
						<td class="kl-shiptype-text">
							<div class="no_stretch kl-shiptype-text">
								<b>{$k.victimshipname}</b>
								<br />
								{if !$killlist_iskloss}
								{$k.victimshipclass}
								{else}
								{$k.victimiskloss}
								{/if}
							</div>
						</td>
						{if !$k.allianceexists}
							<td class="kb-table-imgcell">&nbsp;</td>
						{else}
							<td class="kb-table-imgcell"><img src="{$k.victimallianceicon}" style="border: 0px; width: 32px; height: 32px;" title="{$k.victimalliancename}" alt="{$k.victimalliancename}" /></td>
							{/if}
						<td class="kl-victim-text">
							<div class="no_stretch kl-victim-text">
								{if $k.loss}
									<a href="{$k.urlvictim}"><b>{$k.victim}</b></a>
									<br />
									<a href="{$k.urlvictimcorp}">{$k.victimcorp}</a>
								{else}
									{if $k.victimalliancename != "None" && $k.victimalliancename != "NONE"}
										<a href="{$k.urlvictim}"><b>{$k.victim}</b></a><br /><a href="{$k.urlvictimall}">{$k.victimalliancename}</a>
									{else}
										<a href="{$k.urlvictim}"><b>{$k.victim}</b></a><br /><a href="{$k.urlvictimcorp}">{$k.victimcorp}</a>
									{/if}
								{/if}
							</div>
						</td>
						<td class="kl-finalblow">
							<div class="no_stretch kl-finalblow">
								<a href="{$k.urlfb}"><b>{$k.fb}</b></a>
								<br />
								<a href="{$k.urlfbcorp}">{$k.fbcorp}</a>
							</div>
						</td>
						<td class="kb-table-cell kl-location">
							<div class="no_stretch kl-location">
								{if $config->get('killlist_regionnames')} {$k.region}, {$k.system}{else}<b>{$k.system}</b>{/if} (<span style="color:{if $k.systemsecurity >= 0.5}green{elseif $k.systemsecurity < 0.05}red{else}orange{/if};">{$k.systemsecurity|max:0|string_format:"%01.1f"}</span>)<br /></div>
								{if $k.inv || $comments_count}
									<div class="kl-inv-comm">
										{if $k.inv}<img src="{$theme_url}/img/involved10_10.png"  alt="I:" /> {$k.inv}{/if}
										{if $comments_count}<span {if  !$k.commentcount}style="visibility: hidden"{/if}><img src="{$theme_url}/img/comment_white13_10.gif" alt="C:" /> {$k.commentcount}</span>{/if}
										{if $k.externalid}<a href="{$k.urldetail}#disqus_thread" class="disqus-comment-count" data-disqus-identifier="{$k.externalid}"></a>{/if}
									</div>
								{/if}
							<div class="kl-date">
								{if $daybreak}
									{if $k.urlrelated}
										<a href="{$k.urlrelated}"><b>{$k.timestamp|date_format:"%H:%M"}</b></a>
									{else}
										<b>{$k.timestamp|date_format:"%H:%M"}</b>
									{/if}
								{else}
									{if $k.urlrelated}
										<a href="{$k.urlrelated}"><b>{$k.timestamp|date_format:"%y-%m-%d"} {$k.timestamp|date_format:"%H:%M"}</b></a>
									{else}
										<b>{$k.timestamp|date_format:"%y-%m-%d"} {$k.timestamp|date_format:"%H:%M"}</b>
									{/if}
								{/if}
							</div>
						</td>
					</tr>
				{/section}
			</tbody>
		</table>
	{sectionelse}
		<p>No data.</p>
	{/section}
</div>
<!-- /killlistable.tpl -->