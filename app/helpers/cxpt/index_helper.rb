module Cxpt::IndexHelper
  def cxpt_nav_link(n,config={})
    if n['controller']
      link_to n['text'],{controller: 'cxpt/'+n['controller'], action: n['action']},config
    else
      link_to n['text'],cxpt_pcate_url(n['text']),config
    end
  end
end
