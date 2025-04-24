import prisma from '$lib/prisma'

export const load = async({ url })=> {
  const { pathname } = url
  const tags = await prisma.tag.findMany({
    where: {
      disabled: false
    }
  })

  tags.unshift({
    id: 0,
    href: '/software',
    label: '全部',
    icon: 'Apps',
    disabled: false,
  })

  let tag = null
  for(const t of tags) {
    if (pathname === t.href) {
      tag = t
      break;
    }
  }

  return {
    tags,
    tag,
    pathname,
  }
}