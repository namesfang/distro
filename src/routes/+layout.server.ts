interface Record {
  label: string
  icon: icons.Name
  href: string
  active: boolean
  target?: string
}

const top: Record[] = [
  {label: '首页', icon: "Home4", active: false, href: '/'},
  {label: '软件', icon: "Apps", active: false, href: '/software'},
  {label: '帮助', icon: "Questionnaire", active: false, href: '/feedback'},
]

const foot: Record[] = [
  {label: '仓库', active: false, icon: 'Github', href: 'https://github.com/namesfang/distro', target: '_blank'},
]

const multi = [
  top,
  foot,
]

export const load = async({ url })=> {

  const { pathname } = url

  for(const children of multi) {
    for(const child of children) {
      if (child.href === '/') {
        child.active = pathname === child.href
      } else {
        child.active = pathname.startsWith(child.href)
      }
    }
  }

  return {
    multi,
  }
}